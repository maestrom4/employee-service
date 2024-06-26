# Start with the official Go image to build the Go binary.
FROM golang:1.19 AS builder

# Set the Current Working Directory inside the container.
WORKDIR /app

# Copy go.mod and go.sum to download dependencies.
# This is done before copying the source code to leverage Docker cache.
COPY go.* ./
RUN go mod download

# Copy the source code into the container.
COPY ./cmd/employee-srv/main.go ./cmd/employee-srv/

# Build the Go app.
# Adjust the path to where your main.go is accordingly.
RUN CGO_ENABLED=0 GOOS=linux go build -o /employee-srv ./cmd/employee-srv/main.go

# Start a new stage from scratch for a lean final image.
FROM alpine:latest

WORKDIR /

# Copy the pre-built binary file from the previous stage.
COPY --from=builder /employee-srv /employee-srv

# Expose port 8080 to the outside world.
EXPOSE 8080

# Command to run the executable.
CMD ["/employee-srv"]
