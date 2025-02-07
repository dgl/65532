ARG BASE=
FROM ${BASE}
# Make the user ourselves, as busybox and Debian don't have the same arguments
# to adduser and busybox refuses to give it a UID of 65532...
RUN echo "nonroot:x:65532:" >> /etc/group && \
  echo "nonroot:x:65532:65532::/home/nonroot:/bin/sh" >> /etc/passwd && \
  echo "nonroot:*:::::::" >> /etc/shadow && \
  mkdir -p /home/nonroot && (cp -a /etc/skel/. /home/nonroot || true) && \
  chown -R nonroot:nonroot /home/nonroot
# Use the UID rather than the name, so Kubernetes runAsNonRoot works correctly
USER 65532:65532
WORKDIR /home/nonroot
