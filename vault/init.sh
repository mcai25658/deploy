#!/bin/bash

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Please install it and run the script again."
    exit 1
else
    echo "curl is already installed."
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Please install it and run the script again."
    exit 1
else
    echo "jq is already installed."
fi

# Check Vault health status
HEALTH_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://0.0.0.0:8200/v1/sys/health)

# If Vault is not initialized (HTTP 501)
if [ $HEALTH_STATUS -eq 501 ]; then
    # Initialize Vault
    INIT_RESPONSE=$(curl --request POST --data '{"secret_shares": 1, "secret_threshold": 1}' http://0.0.0.0:8200/v1/sys/init)
    KEYS=$(echo $INIT_RESPONSE | jq -r '.keys[0]')
    KEYS_BASE64=$(echo $INIT_RESPONSE | jq -r '.keys_base64[0]')
    ROOT_TOKEN=$(echo $INIT_RESPONSE | jq -r '.root_token')

    # Unseal Vault with the key obtained
    curl --request POST --data "{\"key\": \"$KEYS\"}" http://0.0.0.0:8200/v1/sys/unseal

    # Save the keys and token to ./.sensitive
    SENSITIVE_FILE="./.sensitive"
    echo "KEYS=$KEYS" > $SENSITIVE_FILE
    echo "KEYS_BASE64=$KEYS_BASE64" >> $SENSITIVE_FILE
    echo "ROOT_TOKEN=$ROOT_TOKEN" >> $SENSITIVE_FILE

    echo "Vault initialized and unsealed."
    echo "Keys, keys_base64, and root token saved to $SENSITIVE_FILE"
else
    echo "Vault is already up and running. No need to initialize or unseal."
fi

# End the script with success message
echo "Script executed successfully!"
exit 0
