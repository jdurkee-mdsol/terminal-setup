FROM amazon/aws-cli

# Install required packages
RUN yum install -y shadow-utils unzip

# Create a non-root user and group
RUN groupadd -r app && useradd -r -g app -m -d /aws app

# Create app directory and give ownership
RUN chown -R app:app /aws

USER app

# Install AWS CLI v2 for ARM64
RUN curl --proto '=https' --tlsv1.2 -sSf "https://desktop-release.q.us-east-1.amazonaws.com/latest/q-aarch64-linux-musl.zip" -o "q.zip"

RUN unzip q.zip

RUN ./q/install.sh --no-confirm

# Default command
CMD ["/bin/bash"]

