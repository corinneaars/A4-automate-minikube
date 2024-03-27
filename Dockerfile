# Use an official base image with bash
FROM ubuntu:20.04

# Install git
RUN apt-get update && apt-get install -y git

# Set the working directory in the container
WORKDIR /app

# Clone your GitHub repository into the container
RUN git clone https://github.com/yourusername/yourrepository.git

# Set execute permissions for your bash script
RUN chmod +x /app/automate.sh
RUN ./automate.sh

# Run your bash script when the container starts
CMD ["/bin/bash", "automate.sh"]