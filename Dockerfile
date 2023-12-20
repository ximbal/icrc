# Use Python 3.7 as the base image
FROM python:3.7

# Argument for setting the mode, default is 'dev'
ARG MODE=dev

# Set the environment variable MODE to the value passed in the build argument
ENV MODE=${MODE}

# Update the package list and install PostgreSQL client version
RUN apt-get update && apt-get install -y postgresql-client

# Copy the application code into the container at /app
COPY . /app

# Set the working directory to /app
WORKDIR /app

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the database initialization script into the container
COPY initialize_db.sh /app/initialize_db.sh

# Give execute permissions to the script
RUN chmod +x /app/initialize_db.sh

# By default, run 'sleep infinity' to keep the container running
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]