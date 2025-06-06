FROM rust:latest as builder

WORKDIR /app
COPY . .

RUN cargo build --release

FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=builder /app/target/release/SolTrader .

CMD ["./SolTrader"] 