# Use the official Ubuntu base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Copy requirements file and application code
COPY requirements.txt /app
COPY devops /app/devops

# Install Python and pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv

# Create a virtual environment
RUN python3 -m venv venv

# Activate the virtual environment and install dependencies
RUN . /app/venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Ensure the virtual environment is activated when the container starts
ENTRYPOINT ["/app/venv/bin/python"]

# Set the default command to run the server
CMD ["devops/manage.py", "runserver", "0.0.0.0:8000"]

