# Vault Operations Guide
---

## **1. Syncing the Vault**
Synchronize your local vault to the server using the following command:
```bash
rsync -avz vault/ user@192.168.174.134:/home/user/vault
```

## **2. Accessing the Server**
Initiate an SSH connection to the server:
```bash
dls@DESKTOP-4E18T4D:~/deploy$ ssh user@192.168.174.134
```

## **3. Docker Operations**

### **a. Switch to Root User**
```bash
user@vault:~/vault$ sudo -s
```

### **b. Start Docker Compose**
```bash
root@vault:/home/user/vault# docker-compose -f vault.yml up -d
```

### **c. Exit Root User**
```bash
root@vault:/home/user/vault# exit
```

## **4. Script Execution**

### **a. Make Script Executable**
```bash
user@vault:~/vault$ chmod +x init.sh
```

### **b. Run the Script**
```bash
user@vault:~/vault$ ./init.sh
```

> **Note:** The output will display the initialization and unsealing status of the vault.

## **5. Handling Sensitive Data**

### **a. Displaying Data**
```bash
user@vault:~/vault$ cat .sensitive
```

### **b. Encrypting the File**
Encrypt the `.sensitive` file and set a password (e.g., `Aa123456`):
```bash
gpg -c .sensitive
```

### **c. Deleting the Original File**
```bash
rm .sensitive
```

### **d. Decrypting the File**
```bash
gpg -o sensitive -d .sensitive.gpg
```

### **e. Deleting the Decrypted File**
After reviewing the decrypted content, ensure to delete the file:
```bash
rm sensitive
```

## **6. GPG Agent (Optional)**
If you wish to kill the GPG agent (useful during testing to avoid cached password prompts):
```bash
gpgconf --kill gpg-agent
```


## **7. 開啟web ui，使用 root token 登入**

http://192.168.174.134:8200/

---



