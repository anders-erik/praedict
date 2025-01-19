
FROM rust:1.84-bookworm

WORKDIR /app

COPY . .

RUN cargo build --release

CMD ["./target/release/rust"]