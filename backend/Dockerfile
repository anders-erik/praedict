
FROM denoland/deno:alpine

WORKDIR /app

ENV SQLITE_PATH=/db/database.sqlite

COPY . .

# Set the default command (can be overridden by docker-compose)
CMD ["deno", "task", "dev"]
