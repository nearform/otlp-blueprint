#!/bin/sh

# Start Jaeger in the background
/go/bin/all-in-one-linux &

sleep 5

# Forward traffic from port 8080 to Jaeger's default port
socat TCP-LISTEN:8080,fork TCP:localhost:16686 &
socat UDP-RECV:5775,fork UDP:localhost:5775 &
socat TCP-LISTEN:14268,fork TCP:localhost:14268 &
socat TCP-LISTEN:14250,fork TCP:localhost:14250 &

# Wait for background processes to finish
wait
