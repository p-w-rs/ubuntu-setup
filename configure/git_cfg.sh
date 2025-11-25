#!/bin/bash
# DEPENDS_ON: essential

# Configure Git
# Sets up global configuration, credentials, and SSH keys

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Configuring Git"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if Git is already configured
CURRENT_USER=$(git config --global user.name 2>/dev/null || echo "")
CURRENT_EMAIL=$(git config --global user.email 2>/dev/null || echo "")

if [ -n "$CURRENT_USER" ] && [ -n "$CURRENT_EMAIL" ]; then
    echo "Git is already configured:"
    echo "  Name:  $CURRENT_USER"
    echo "  Email: $CURRENT_EMAIL"
    echo ""
    read -p "Do you want to reconfigure? (y/N): " response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo ""
        echo "Keeping existing Git configuration."
        echo ""
        # Still check SSH key
        if [ ! -f "$HOME/.ssh/id_ed25519.pub" ]; then
            echo "No SSH key found. Continuing to SSH key setup..."
            echo ""
        else
            echo "✓ Git is configured and SSH key exists."
            exit 0
        fi
    fi
fi

# Get user details
if [[ ! "$response" =~ ^[Yy]$ ]] || [ -z "$CURRENT_USER" ]; then
    echo "→ Enter your Git configuration details:"
    echo ""

    read -p "Full Name: " GIT_NAME
    read -p "Email: " GIT_EMAIL

    # Set global Git configuration
    echo ""
    echo "→ Configuring Git..."
    git config --global user.name "$GIT_NAME"
    git config --global user.email "$GIT_EMAIL"
fi

# Set recommended Git defaults
echo "→ Setting recommended defaults..."
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global core.editor "nvim"
git config --global color.ui auto
git config --global credential.helper store

# SSH key generation
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  SSH Key Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

SSH_DIR="$HOME/.ssh"
SSH_KEY="$SSH_DIR/id_ed25519"

# Check if SSH key already exists
if [ -f "$SSH_KEY" ]; then
    echo "SSH key already exists at: $SSH_KEY"
    echo ""
    read -p "Do you want to create a new SSH key? (y/N): " response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo ""
        echo "Keeping existing SSH key."
        echo ""
        echo "Your public key:"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        cat "$SSH_KEY.pub"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "Add this key to GitHub:"
        echo "  https://github.com/settings/keys"
        exit 0
    fi
fi

# Create SSH directory if it doesn't exist
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

# Generate SSH key
EMAIL=$(git config --global user.email)
echo "→ Generating new SSH key..."
ssh-keygen -t ed25519 -C "$EMAIL" -f "$SSH_KEY" -N ""

# Start ssh-agent and add key
echo ""
echo "→ Adding key to ssh-agent..."
eval "$(ssh-agent -s)" > /dev/null 2>&1
ssh-add "$SSH_KEY" > /dev/null 2>&1

echo ""
echo "✓ Git configured successfully!"
echo ""
echo "Configuration:"
echo "  Name:  $(git config --global user.name)"
echo "  Email: $(git config --global user.email)"
echo "  Editor: $(git config --global core.editor)"
echo "  Default branch: $(git config --global init.defaultBranch)"
echo ""
echo "Your public SSH key:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
cat "$SSH_KEY.pub"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "To use this key with GitHub:"
echo "  1. Copy the key above"
echo "  2. Go to: https://github.com/settings/keys"
echo "  3. Click 'New SSH key'"
echo "  4. Paste the key and give it a title"
echo ""
echo "Test your connection with:"
echo "  ssh -T git@github.com"
echo ""
