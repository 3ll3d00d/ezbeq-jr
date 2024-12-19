# ezbeq-jr

Creates and publishes an image for [ezBEQ](https://github.com/3ll3d00d/ezbeq) to github packages, for use with [JRiver Media Center](https://www.jriver.com), or any ezBEQ client that uses the [MiniDSP-RS](https://github.com/mrene/minidsp-rs) project.

> [!NOTE]
> ⚠ This image has not been tested with USB connected devices.
> There are instructions on how to mount USB devices, from another legacy docker image project:
> - [General docker discussion](https://github.com/jmery/ezbeq-docker/tree/ef3f954f37b1b420e31635a699bfbb864e861ad9?tab=readme-ov-file#general-linux-docker-instructions)
> - [Synology NAS discussion](https://github.com/jmery/ezbeq-docker/tree/ef3f954f37b1b420e31635a699bfbb864e861ad9?tab=readme-ov-file#general-linux-docker-instructions)
>  - [Higher privileges discussion](https://github.com/jmery/ezbeq-docker/tree/ef3f954f37b1b420e31635a699bfbb864e861ad9?tab=readme-ov-file#note-on-execute-container-using-high-privilege)

## Setup

- Expects a volume mapped to `/config `to allow user supplied `ezbeq.yml`

Example docker compose file for your reference: [docker-compose.yaml](./docker-compose.yaml)

## FAQ

> Why is it called `-jr`?
 
JR stands for [JRiver Media Center](https://www.jriver.com)

> Does this docker image work for [MiniDSP](https://www.minidsp.com) devices?

Yes.

> Does this build and publish an image for every ezBEQ release?

Yes, see https://github.com/3ll3d00d/ezbeq/blob/main/.github/workflows/create-app.yaml#L108

> Why is this not mentioned in the ezBEQ readme?

It is, in the [Docker section](https://github.com/3ll3d00d/ezbeq?tab=readme-ov-file#docker).


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