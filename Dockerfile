
FROM amazonlinux:latest

MAINTAINER hello@saiprakash

# Create directory for Tomcat and set working directory
RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat

# Install necessary packages
RUN yum install -y tar wget gzip

# Download Apache Tomcat 9.0.86 source code
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.87/bin/apache-tomcat-9.0.87.tar.gz

# Unzip Apache Tomcat 9 source code and rename directory
RUN tar -zxvf apache-tomcat-9.0.87.tar.gz \
    && extracted_dir=$(tar -tf apache-tomcat-9.0.87.tar.gz | head -1 | cut -f1 -d'/') \
    && mv "$extracted_dir" tomcat9

# Install Java
RUN yum -y install java
RUN java -version

# Expose Tomcat port
EXPOSE 8080

# Set environment variables
ENV CATALINA_HOME /opt/tomcat/tomcat9
ENV PATH $CATALINA_HOME/bin:$PATH

# Start Tomcat using catalina.sh
CMD ["catalina.sh" , "run"]
