# Wordle in Cold Fusion

## start

```
podman run --rm -it -p 8500:8500 -e acceptEULA=YES -v $(pwd)/app:/app --name coldwordle adobecoldfusion/coldfusion:latest
```