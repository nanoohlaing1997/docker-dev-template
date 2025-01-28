# Use the official Python runtime as a base image which supports ARM64
ARG PYTHON_VERSION=3.10-slim
FROM python:${PYTHON_VERSION}

# Install sudo
RUN apt-get update && apt-get install -y sudo && \
	echo 'noh ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers


# Use arguments for user configuration
ARG USER=noh
ARG UID=1000

# Install system dependencies required for Pandas and other packages
RUN apt-get update && apt-get install -y \
	gcc \
	libc-dev \
	libffi-dev \
	build-essential

# Create a non-root user and set working directory
RUN groupadd -g ${UID} ${USER} && \
	useradd -m -u ${UID} -g ${USER} -s /bin/bash ${USER}

WORKDIR /var/www

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
# COPY . .

# Set ownership to the non-root user
RUN chown -R ${USER}:${USER} /var/www

# Use the non-root user to run the application
USER ${USER}

# Optional: Expose a port if your application is a web service
# EXPOSE 8080 9090

# Define the command to run your app (modify accordingly)
# CMD ["python", "app.py"]
