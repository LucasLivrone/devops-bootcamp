## Poke-Challenge

Instructions:
https://github.com/roxsross/devops-practice-tools/tree/master/docker/challenge/poke-app

---


```
aws ec2 run-instances --image-id ami-08c40ec9ead489470 --instance-type t3.medium --key-name poke_key --security-group-ids sg-0d7f352c975bd7835 --count 1 --user-data file://poke-challenge.sh --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=poke-challenge-ec2}]'
```