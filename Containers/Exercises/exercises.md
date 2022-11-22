URL to exercises notes:

https://github.com/roxsross/devops-practice-tools/tree/master/docker/exercises

--- 

### Exercise 04
```
cd Containers/Exercises/04/   
docker build -t testing:1.0.0 .   
docker tag testing:1.0.0 lucaslivrone/testing:1.0.0   
docker push lucaslivrone/testing:1.0.0    
```