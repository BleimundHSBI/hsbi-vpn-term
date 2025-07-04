#!/bin/bash

# Set the working directory to where your docker-compose.yml is
PROJECT_DIR="$(pwd)"

# Create the applications folder
DESKTOP_DIR="$HOME/.local/share/applications"
mkdir -p "$DESKTOP_DIR"

# Move the icon to the icon path
mkdir -p ~/.local/share/icons
cp "$PROJECT_DIR/terminal-hsbi.png" ~/.local/share/icons/

# Create .desktop file content
DESKTOP_FILE="$DESKTOP_DIR/hsbi-vpn-terminal.desktop"
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=HSBI VPN Terminal
Comment=Launch Terminal over VPN using Docker Compose
Exec=sh -c "cd '$PROJECT_DIR' && docker compose run --rm vpn-terminal; $SHELL"
Icon=terminal-hsbi
Terminal=true
Categories=Network;WebBrowser;
EOF

chmod +x "$DESKTOP_FILE"

echo "Desktop shortcut installed: $DESKTOP_FILE"
echo "Reminder: By default your Downloads and ~/git folder are synced. To add more edit the docker-compose.yml"

echo "Process to build the container? \n
If this is the first time you run the script select Y, else your can ignore."
read -p "Build? [Y/n]" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
docker build -t vpn-terminal .
fi
