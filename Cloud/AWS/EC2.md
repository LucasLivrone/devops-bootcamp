
### Manual steps to create and lunch an EC2 instance:

1. Create a Security group. Add inbound rules for ports 80, 443 and 22 (only use My IP for the last one and use your name as description)      
2. Create a Key pair (use rsa and .pem)    
3. Create an instance. Remember to link the Key pair and select the existing Security group    
4. In order to connect to the instance it's easier to use SSH client. Remember to give permissions **chmod 400** the key before running the **ssh** command.

---

### User data
It's basically a script that will be run whenever we create an instance.       
Once the instance is loaded, it would have already run the user data.

For example:  

```bash
#!/bin/bash     
sudo apt-get update     
sudo apt install nginx -y   
sudo systemctl enable nginx     
sudo systemctl start nginx
```
##### (By default, **nginx** will not work if you use https)   
---

### Naming convention
You should follow a naming convention for your resources.   
For example, add -ec2 at the end of an instance name, -sg at the end of a security group, etc...