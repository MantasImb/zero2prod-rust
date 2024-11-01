FROM rust:latest

# Let's switch our working directory to /app
# The 'app' directory will be created for us by Docker in case it doesn't exist
WORKDIR /app

# Install the required system dependencies for our linking configuration
RUN apt update && apt install lld clang -y

# Copy all files for our working environment to our Docker image
COPY . .

ENV SQLX_OFFLINE=true

# Let's build our binary!
# We'll use the release profile to make it fast
RUN cargo build --release

# When `docker run` is executed, launch the binary
ENTRYPOINT ["/app/target/release/zero2prod"]
