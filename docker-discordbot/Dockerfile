FROM debian:buster

RUN 	apt update; \
	apt-get install -y --no-install-recommends default-jre unzip

#compile the java files to .jar 
RUN javac src/main/java/core/Main.java

COPY ./fsibot.zip /fsibot.zip

#CMD [""]
	 
