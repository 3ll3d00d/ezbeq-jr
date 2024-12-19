# ezbeq-jr

Creates and publishes an image for [ezbeq](https://github.com/3ll3d00d/ezbeq) to github packages, for use with [JRiver Media Center](https://www.jriver.com).

* Exposes port 8080 
* Expects a volume mapped to /config to allow user supplied ezbeq.yml 

## FAQ

> Why is it called `-jr`?
 
JR stands for [JRiver Media Center](https://www.jriver.com)

> Does this docker image work for [MiniDSP](https://www.minidsp.com) devices?

Yes.

> Does this build and publish an image for every ezBEQ release?

Yes, see https://github.com/3ll3d00d/ezbeq/blob/main/.github/workflows/create-app.yaml#L108

> Why is this not mentioned in the ezBEQ readme?
 
It is, here: XXXXXX WIP!


> What architectures are supported?

The docker image get's built to target:

- `linux/amd64`
- `linux/arm64`

---

## Developer Documentation

### Multi Platform Docker Image

Build for two architectures in parallel, push:

```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t <HUB USERNAME>/ezbeq-jr:latest \
  --push .
```

#### Setup

Requires Docker's `buildx` setup:

- `docker buildx create --use`
- `docker buildx inspect --bootstrap`