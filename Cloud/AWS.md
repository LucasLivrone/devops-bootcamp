
## AWS Sandbox Environment

Remember to modify access keys for each new lab by updating **~/.aws/credentials**  
Then we can run the following command to verify:    
``aws sts get-caller-identity ``    
And we should see our email.

If you don't have that folder available, you should run the command:      
``aws configure  ``      
and fill the credentials (output format: **json**)

