#!/bin/bash

# Read the unseal key from an environment variable or secret management service
UNSEAL_KEY=${VAULT_UNSEAL_KEY}

# Unseal Vault
vault operator unseal $UNSEAL_KEY
