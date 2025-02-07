# 65532

What? This is the UID of the "nonroot" user in Google's distroless images.

Sometimes it's useful to have a full image where it has a proper user account
that matches this non-root UID.

## Why?

### Running as non-root

In Kubernetes `runAsNonRoot` is a [good
idea](https://cheatsheetseries.owasp.org/cheatsheets/Kubernetes_Security_Cheat_Sheet.html).
It has some downsides though, many application images can safely run as a
non-root user by default, but OS images usually expect a user to customise them
via a Dockerfile.

These are useful to use as an image with `kubectl debug`, among some other use
cases. You probably don't want to base your container on them, just add a
non-root user yourself.

### Can't you just set the UID?

Sure. Do what you like. The value of this is the image has an actual home
directory which the user owns as well as the UID having an account called
"nonroot".

The use is mostly for debugging on Kubernetes clusters where you have a
namespace configured with the restricted pod security standard that doesn't
allow root access.

## Using

With Docker:

```shell
docker run -it 65532/debian
```

With Kubernetes:

```shell
kubectl run -it --image=65532/debian test
```

There are tags matching the codenames of the releases for Debian and Ubuntu,
latest points at the same place as the upstream tag. See
https://hub.docker.com/u/65532.
