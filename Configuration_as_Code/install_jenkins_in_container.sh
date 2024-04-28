#Create a bridge network in Docker
sudo docker network create jenkins

#To execute Docker commands inside Jenkins nodes, download and run the docker:dind Docker image
sudo docker run   --name jenkins-docker   --rm   --detach   --privileged   --network jenkins   --network-alias docker   --env DOCKER_TLS_CERTDIR=/certs   --volume jenkins-docker-certs:/certs/client   --volume jenkins-data:/var/jenkins_home   --publish 2376:2376   docker:dind   --storage-driver overlay2

#Build a new docker image from this Dockerfile, and assign the image as myjenkins
sudo docker build -t myjenkins:2.440.3-1 .

#Run your own myjenkins:2.440.3-1 image as a container in Docker
sudo docker run   --name jenkins   --restart=on-failure   --detach   --network jenkins   --env DOCKER_HOST=tcp://docker:2376   --env DOCKER_CERT_PATH=/certs/client   --env DOCKER_TLS_VERIFY=1   --publish 8080:8080   --publish 50000:50000   --volume jenkins-data:/var/jenkins_home   --volume jenkins-docker-certs:/certs/client:ro   myjenkins:2.440.3-1

sleep 10

sudo docker images
sudo docker ps -a

#Print out initial password
sudo docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword