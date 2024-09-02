# Use the latest official Python image that is actually available
FROM python:3.11

# Prevent Python from writing .pyc files to disk
ENV PYTHONDONTWRITEBYTECODE=1
# Ensure Python output is sent directly to the terminal (stdout/stderr) without being buffered
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y netcat-openbsd

# Set the working directory inside the container
WORKDIR /app

# Upgrade pip to the latest version
RUN pip install --upgrade pip

# Copy the requirements file into the container
COPY requirements.txt /app/

# Install any dependencies listed in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY ./entrypoint.sh /app/entrypoint.sh
RUN sed -i 's/\r$//g' /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Copy the current directory contents into the container's working directory (/app)
COPY . /app/

# Expose port 8000 to the outside world (host machine)
EXPOSE 8000

ENTRYPOINT [ "/app/entrypoint.sh" ]

# Command to run your Django app
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]