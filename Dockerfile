# Use an official base image (e.g., Debian)
FROM debian:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg2 \
    ca-certificates

# Download and install OpenJDK 20
RUN wget https://download.java.net/java/GA/jdk20/20/GPL/openjdk-20_linux-x64_bin.tar.gz && \
    tar -xzf openjdk-20_linux-x64_bin.tar.gz && \
    mv jdk-20 /usr/local/ && \
    ln -s /usr/local/jdk-20/bin/java /usr/bin/java && \
    ln -s /usr/local/jdk-20/bin/javac /usr/bin/javac

# Install Maven
RUN apt-get update && apt-get install -y maven

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set JAVA_HOME environment variable
ENV JAVA_HOME /usr/local/jdk-20

# Set the working directory
WORKDIR /app

# Print versions to verify installation
RUN java -version && mvn -version