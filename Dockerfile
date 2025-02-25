# Use an official Python base image
FROM python:3.12

# Set the working directory inside the container
WORKDIR /app

# Copy the project files into the container
COPY . .

# Create a virtual environment and install dependencies inside it
RUN python -m venv /venv \
    && /venv/bin/pip install --upgrade pip \
    && /venv/bin/pip install -r requirements.txt

# Set the default path to use the virtual environment
ENV PATH="/venv/bin:$PATH"

# Expose the port FastAPI runs on
EXPOSE 8000

# Run the FastAPI application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
