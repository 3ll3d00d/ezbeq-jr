# Build stage: Used to prepare the application with all necessary tools and dependencies
FROM python:3.11-slim-bullseye AS builder

# Set the working directory inside the container
WORKDIR /app

# Install dependencies required for building the application
RUN apt-get update && apt-get install --no-install-recommends -y \
    # Tools for compiling and building packages
    build-essential \
    # SSL library development headers
    libssl-dev \
    # Foreign Function Interface library headers
    libffi-dev \
    # YAML parser and emitter library headers
    libyaml-dev \
    # Utility for downloading files
    curl \
    # Git for version control
    git \
    # Python virtual environment creation tool
    python3-venv && \
    python -m pip install --upgrade pip  # Upgrade pip to the latest version

# Create a Python virtual environment at /opt/venv
RUN python -m venv /opt/venv

# Add the virtual environment to the PATH
ENV PATH="/opt/venv/bin:${PATH}"

# Copy the Python requirements file into the container
COPY requirements.txt ./

# Install the Python dependencies listed in requirements.txt
RUN pip install --pre --no-cache-dir -r requirements.txt

# Runtime stage: A clean, lightweight image for running the application
FROM python:3.11-slim-bullseye

# Set the environment variable for ezbeq configuration
ENV EZBEQ_CONFIG_HOME=/config

# Copy the Python virtual environment prepared in the build stage
# This brings only the necessary runtime dependencies from the build stage.
COPY --from=builder /opt/venv /opt/venv

# Set the working directory inside the container
WORKDIR /app

# Define a volume for configuration data
VOLUME ["/config"]

# Add the virtual environment to the PATH
ENV PATH="/opt/venv/bin:${PATH}"

# Install runtime-only dependencies required by the application
RUN apt-get update && apt-get install --no-install-recommends -y \
    # Utility for downloading files
    curl \
    # SQLite database command-line tool
    sqlite3

# Create a non-root user and group for running the application
RUN groupadd -r ezbeq && useradd -r -g ezbeq ezbeq

# Set ownership of the application and configuration directories to the new user
RUN chown -R ezbeq:ezbeq /app /config

# Switch to the non-root user
USER ezbeq

# Download and install the pre-built minidsp-rs binary
# Using the pre-built binary avoids the need to compile minidsp-rs from source, saving time and reducing complexity.
RUN curl -L -o /usr/local/bin/minidsp https://github.com/mrene/minidsp-rs/releases/latest/download/minidsp && \
    chmod +x /usr/local/bin/minidsp

# Define a health check for the application to verify it's running correctly
HEALTHCHECK --interval=10s --timeout=2s \
  CMD curl -f -s --show-error http://localhost:8080/api/1/version || exit 1

# Expose port 8080 for the application to listen on
EXPOSE 8080

# Define the default command to run the ezbeq application
CMD [ "ezbeq" ]