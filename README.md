# ezbeq-jr

Creates and publishes an image for [ezbeq](https://github.com/3ll3d00d/ezbeq) to github packages, for use with [JRiver Media Center](https://www.jriver.com).

* Exposes port 8080 
* Expects a volume mapped to /config to allow user supplied ezbeq.yml 

## FAQ

> Why is it called `-jr`?
 
JR stands for [JRiver Media Center](https://www.jriver.com)

> Does this docker image work for [MiniDSP](https://www.minidsp.com) devices?

No, MiniDSP needs additional binaries. See issue [#79](https://github.com/3ll3d00d/ezbeq/issues/79).

> Does this build and publish an image for every ezBEQ release?

Yes, see https://github.com/3ll3d00d/ezbeq/blob/main/.github/workflows/create-app.yaml#L108

> Why is this not mentioned in the ezBEQ readme?
 
Because it's just what I use for my own setup (which I run on unraid)
