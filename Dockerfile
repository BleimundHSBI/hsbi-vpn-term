FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openconnect \
    xterm \
    lsd \
    lazygit \
    sudo \
    curl \
    && apt-get clean

# Set up user
RUN useradd -m vpnuser && echo 'vpnuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
COPY connect.sh /home/vpnuser/connect.sh
RUN chown vpnuser:vpnuser /home/vpnuser/connect.sh && chmod +x /home/vpnuser/connect.sh

USER vpnuser
WORKDIR /home/vpnuser

CMD ["./connect.sh"]
