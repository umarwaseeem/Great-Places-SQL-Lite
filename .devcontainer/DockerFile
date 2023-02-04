# Use the official Ubuntu image as a parent image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages and Flutter dependencies
RUN apt-get update \
&& apt-get install -y curl unzip libglu1-mesa fonts-crosextra-carlito fonts-crosextra-caladea libqt5widgets5 lib32z1 openjdk-8-jdk-headless qemu-kvm \
&& apt-get clean

# Download and install Flutter
RUN curl https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_1.22.6-stable.tar.xz -o flutter.tar.xz \
&& tar xf flutter.tar.xz \
&& rm flutter.tar.xz

# Set environment variables
ENV FLUTTER_HOME /flutter
ENV PATH $PATH:$FLUTTER_HOME/bin

# Download and install Android SDK
RUN curl https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip -o commandlinetools.zip \
&& unzip commandlinetools.zip \
&& rm commandlinetools.zip \
&& mv tools /opt/android-sdk

# Set environment variables
ENV ANDROID_HOME /opt/android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools/bin

# Run Flutter doctor
RUN flutter doctor
