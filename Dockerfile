# Start with the latest Rocky Linux 8
FROM rockylinux:8
LABEL org.opencontainers.image.base.name="rockylinux:8"

# Upgrade any out-of-date packages
RUN dnf upgrade -y && \
    dnf clean all

# Install Perl
RUN dnf install -y perl && \
    dnf clean all

# Copy the GitHub working dir into the image.
COPY . /HATS

# Remove the .git directory & any input files, then make the output directory.
RUN rm -rf /HATS/.git /HATS/input/* && \
    mkdir /HATS/output

# The script use imports relative to the current working directory, so make
# sure we start inside HATS.
WORKDIR /HATS

# If no other command is provided, run a simple handler script!
# The handler script assumes that two things have been bind-mounted into the
# container:
# * A file inside the directory at container path /HATS/input/, whose name
#   starts with "hla_prot.fasta".
# * A directory at container path /HATS/output, which is empty.
CMD ["/HATS/dockerscript.sh"]
