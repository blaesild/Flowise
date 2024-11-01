FROM n8nio/n8n:latest

USER root

# Install FFMPEG and other necessary tools
RUN apk update && apk add --no-cache \
    ffmpeg \
    && rm -rf /var/cache/apk/*

# Install n8n-nodes-base to ensure compatibility with community nodes
RUN npm install -g n8n-nodes-base

# Install specified community nodes
RUN npm install -g n8n-nodes-ffmpeg n8n-nodes-elevenlabs

# Set an environment variable to allow external modules (required for community nodes)
ENV NODE_FUNCTION_ALLOW_EXTERNAL=* 

# Create a directory for custom nodes
RUN mkdir -p /home/node/.n8n/custom

# Switch back to the node user
USER node

# Set the working directory
WORKDIR /home/node

# Expose the default n8n port
EXPOSE 5678

# Start n8n
CMD ["n8n", "start"]
