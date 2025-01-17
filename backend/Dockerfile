# Use the official Deno image
FROM denoland/deno:alpine

# Set the working directory in the container
WORKDIR /app

# Copy your application files
COPY src ./src

# Set the default command (can be overridden by docker-compose)
CMD ["deno", "run", "--allow-net", "--allow-read", "src/main.ts"]
