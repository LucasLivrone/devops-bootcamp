
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

### Launch an instance using AWS CLI
https://docs.aws.amazon.com/cli/latest/reference/ec2/run-instances.html 

```
aws ec2 run-instances --image-id <id> --instance-type <name> --key-name <name> --security-group-ids <id> --count <number of instances> --user-data file://<file>  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=<name>}]'
```

Ubuntu **image-id** can be found at https://cloud-images.ubuntu.com/locator/ec2/ (us-east-1)  
**instance-type**  can be found at https://aws.amazon.com/ec2/instance-types/ 


You can press Q once the command is run to take back the terminal.

Example:  
```  
aws ec2 run-instances --image-id ami-08c40ec9ead489470 --instance-type t3.micro --key-name bootcamp --security-group-ids sg-0a7615db48f72d6ae --count 1 --user-data file://user-data.sh --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=bootcamp-ec2-instance}]'
``` 


---

### Naming convention
You should follow a naming convention for your resources.   
For example, add -ec2 at the end of an instance name, -sg at the end of a security group, etc...

---

### Teacher notes
Tag instances:  
``aws ec2 create-tags --resources i-0b0857eb7dc5ac3ca --tags Key=Name,Value=MyInstance``

List instances:     
``aws ec2 describe-instances``


Filter instances:   
``aws ec2 describe-instances --filters "Name=instance-type,Values=t3.medium" --query "Reservations[].Instances[].InstanceId"``

---