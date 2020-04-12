## CI/CD For SpringBoot HelloWorld Application

### *Table of Contents*
1. Spring application deployment on Tomcat Server
2. Deploy Docker Image (Spring application) on a Container 
3. Deploy Docker Container on a Kubernetes Environment
---
### *Spring application deployment on Tomcat Server*

1. [GS Spring boot application](https://github.com/spring-guides/gs-spring-boot) -> Tomcat Server application built into Spring -> Cloned application from Github.
2. Navigate to complete folder.

    * Build this spring boot application. Jar file is stored in target folder
         ```bash 
         foo@bar:~$ mvn package
         ``` 
    * Run the build application 
        ```bash
        foo@bar:~$ mvn spring-boot:run
        ``` 
3. View the tomcat deployed app on your browser -> http://localhost:8080/
---
### *Deploy Docker Image (Spring application) on a Container*

1. In the complete folder, create a docker file.
     ```bash 
     foo@bar:~$ touch Dockerfile
     ``` 
2. Modify Dockerfile in IntelliJ
    ```bash
    FROM openjdk:latest
    WORKDIR ./ ./
    COPY ./target/*.jar ./app.jar
    CMD ["java", "-jar", "./app.jar"]
    ```
    
4. List all running containers
      ```bash 
      foo@bar:~$ docker ps
      ``` 
5. List all containers
     ```bash 
     foo@bar:~$ docker ps -a
     ``` 
6. List all docker images 
     ```bash 
     foo@bar:~$ docker images
     ``` 
7. Build the docker image with REPOSITORY and TAG value. 
     ```bash 
     foo@bar:~$ docker build -t arjuns93/helloworld:latest .
     ``` 
8. Run the docker image into a container by port forwarding actual port: container port
     ```bash 
     foo@bar:~$ docker run -p 8080:8080 arjuns93/helloworld
     ``` 
9. ssh into container 
     ```bash 
     foo@bar:~$ docker exec -it arjun93/helloworld /bin/bash
     ``` 
10. Login to docker using docker id and password. It will ask for user name and password
     ```bash 
     foo@bar:~$ docker login
     ``` 
11. Pushing docker image to docker hub 
     ```bash 
     foo@bar:~$ docker push arjuns93/helloworld:latest
     ``` 
---
### *Deploy Docker Container on a Kubernetes Environment*

One time Setup:

  1. [Install Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-macos)
  2. [Install Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)


Steps:

1. Start minikube using ```minikube start```. It is an orchestrator [Has it’s own VM] -> Starts minikube using hyperkit -> Unable to pull docker image using hyperkit -> use ```minikube start --driver=docker``` -> able to pull docker images using this command -> Drawback is that you won’t get an external url if you are using load balancer. We might have to switch to AWS or Azure or Google Cloud for those services.
    ```bash 
    foo@bar:~$ minikube start --driver=docker
    ``` 
2. Create kubernetes deployment file in complete folder
    ```bash 
    foo@bar:~$ touch deployment.yaml
    ``` 
3. Components needed for this kubernetes deployment:
    1. Pod deployment
    2. NodePort Service
4. Applying deployment.yaml configuration
    ```bash 
    foo@bar:~$ kubectl apply -f deployment.yaml
    ``` 
5. Retrieve all deployed resource and service in kubernetes environment 
    ```bash 
    foo@bar:~$ kubectl get all
    ``` 
6. This will generate something like
    1. service/helloworld-app   NodePort    10.96.27.231   <none>        8080:31393/TCP   5s
    2. There is no external url for above app.
    3. To obtain external url
        ```bash 
        foo@bar:~$ minikube service helloworld-app --url
        ``` 
---
### Additional info:
1. Retrieve all secret in kubernetes environment -> ```kubectl get secret```
2. Delete all deployed resource in kubernetes environment that got created because of deployment.yaml -> ```kubectl delete -f deployment.yaml```



