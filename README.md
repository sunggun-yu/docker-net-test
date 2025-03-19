# Network Testing Docker Image

[![Build and Publish Docker Image](https://github.com/sunggun-yu/docker-net-test/actions/workflows/docker-build.yml/badge.svg)](https://github.com/sunggun-yu/docker-net-test/actions/workflows/docker-build.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/sunggun/net-test.svg)](https://hub.docker.com/r/sunggun/net-test/)

A lightweight Alpine-based Docker image packed with network diagnostic and testing tools. Perfect for troubleshooting network connectivity issues in Kubernetes environments.

## Features

- **Lightweight**: Based on Alpine Linux for minimal image size
- **Comprehensive**: Includes a wide range of networking utilities
- **Multi-architecture**: Supports amd64, arm64, and armv7
- **Security-focused**: Runs as non-root user

## Included Tools

| Category | Tools |
|----------|-------|
| **DNS Tools** | `bind-tools` (dig, nslookup), `drill` |
| **Connection Testing** | `busybox-extras` (telnet), `ping`, `netcat-openbsd`, `nmap` |
| **Path Analysis** | `traceroute`, `mtr`, `tcptraceroute` |
| **Traffic Analysis** | `tcpdump` |
| **HTTP Tools** | `curl`, `wget`, `wrk`, `apache2-utils` (ab) |
| **Network Configuration** | `net-tools`, `iproute2`, `iptables` |
| **Network Calculation** | `ipcalc` |
| **SSL/TLS** | `openssl`, `ca-certificates` |
| **Data Processing** | `jq`, `yq` |
| **File Transfer** | `rsync` |
| **Text Editors** | `vim`, `nano` |

## Usage

### Pull the Image

From Docker Hub:
```bash
docker pull sunggun/net-test:latest
```

From GitHub Container Registry:
```bash
docker pull ghcr.io/sunggun-yu/net-test:latest
```

### Run Locally

```bash
docker run -it --rm sunggun/net-test
```

For full network capabilities:
```bash
docker run -it --rm --cap-add=NET_ADMIN --cap-add=NET_RAW sunggun/net-test
```

### Use in Kubernetes

Create a debugging pod:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: network-debugger
spec:
  containers:
  - name: net-test
    image: sunggun/net-test:latest
    command: ["sleep", "infinity"]
    securityContext:
      capabilities:
        add:
        - NET_RAW
        - NET_ADMIN
```

Or use it directly for quick troubleshooting:

```bash
kubectl run net-debugger --rm -it --image=sunggun/net-test -- bash
```

### Build locally

```bash
# Initialize Docker buildx
docker buildx create --use

# Build the image for Linux AMD
docker buildx build --platform linux/amd64 -t sunggun/net-test:latest .

# Push the image for Linux AMD
docker buildx build --platform linux/amd64 -t sunggun/net-test:latest --push .

# Build the image for macOS ARM
docker buildx build --platform linux/arm64/v8 -t sunggun/net-test:latest .

# Push the image for macOS ARM
docker buildx build --platform linux/arm64/v8 -t sunggun/net-test:latest --push .
```

## Example Uses

### Test DNS Resolution
```bash
dig example.com
drill example.com
```

### Check Connectivity
```bash
ping -c 3 8.8.8.8
tcptraceroute google.com 443
mtr --report --count 10 example.com
```

### Scan Ports
```bash
nmap -p 80,443,8080 service-name.namespace.svc.cluster.local
```

### Test HTTP Endpoints
```bash
curl -v https://example.com
wrk -t2 -c10 -d30s http://service-name:8080/health
```

### Analyze TLS Certificates
```bash
openssl s_client -connect example.com:443 </dev/null | openssl x509 -noout -text
```

### Inspect Network Traffic
```bash
tcpdump -i any port 80 -n
```

### Calculate IP Information
```bash
ipcalc 10.0.0.0/16
```

## Tags

- `latest`: Latest stable build
- `vX.Y.Z`: Specific version (e.g., v1.0.0)
- `vX.Y`: Minor version (e.g., v1.0)
- `vX`: Major version (e.g., v1)

## Security Note

This image runs as the `nobody` user (UID 65534) by default for improved security. Some networking tools may require additional capabilities when running in containers.

## License

MIT License - See [LICENSE](LICENSE) for details.
