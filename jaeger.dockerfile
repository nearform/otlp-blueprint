# Use an alpine-based image that includes the Jaeger binary
FROM jaegertracing/all-in-one:latest AS jaeger
FROM alpine:latest

# Copy the Jaeger binary from the jaeger image
COPY --from=jaeger /go/bin/all-in-one-linux /go/bin/all-in-one-linux

# Install socat
RUN apk add --no-cache socat

# Set the entrypoint to a script that starts Jaeger and socat
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]