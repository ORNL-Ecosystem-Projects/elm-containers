FROM spack/ubuntu-jammy:0.23.0

ARG DATA_FILE=files.txt
ENV DATA_FILE=${DATA_FILE}

# Set up environment variables
ENV INPUT_DATA_DIR=/projects/e3sm/inputdata \
    USER=ghciocitester \
    TZ=America/Eastern \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    BASE_URL=https://web.lcrc.anl.gov/public/e3sm/inputdata

# Install required packages, clean up after
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y remove cmake && \
    apt-get -y install software-properties-common wget && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Set git user info
RUN git config --global user.email "${USER}@${USER}.${USER}" && \
    git config --global user.name "${USER}"

# Create input data directory
RUN mkdir -p $INPUT_DATA_DIR /app

# Build download script
RUN cat > /app/download.sh <<'EOF'
#!/bin/bash
set -e
while read -r relative_path; do
    file_url="${BASE_URL}/${relative_path}"
    file_loc="${INPUT_DATA_DIR}/${relative_path}"
    mkdir -p "$(dirname "$file_loc")"
    echo "Downloading $file_url -> $file_loc"
    wget -q -O "$file_loc" "$file_url"
done < /app/files.txt
EOF

RUN chmod +x /app/download.sh

# Copy file list
COPY ${DATA_FILE} /app/files.txt

# Run download script
RUN /app/download.sh

ENTRYPOINT ["/bin/bash", "--rcfile", "/etc/profile", "-l"]
