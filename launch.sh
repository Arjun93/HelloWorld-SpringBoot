mvn package
docker build -t arjuns93/helloworld:latest .
docker push arjuns93/helloworld:latest
kubectl apply -f deployment.yaml
kubectl get all
minikube service helloworld-app --url