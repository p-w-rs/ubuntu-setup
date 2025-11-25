#!/bin/bash
# REQUIRES_SUDO: yes
# DEPENDS_ON: logiops

# Configure logiops
# Sets up configuration for Logitech MX Master mice and enables service

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Configuring logiops"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Create logiops config file
echo "→ Creating logiops configuration..."
cat > /etc/logid.cfg << 'LOGID_EOF'
devices: (
{
  name: "MX Master 3";

  # SmartShift for automatic fast scrolling
  smartshift:
  {
    on: true;
    threshold: 20;
    torque: 50;
  };

  # Natural scrolling with adjusted speed
  hiresscroll:
  {
    hires: false;
    invert: true;
    target: false;
  };

  # Thumb wheel settings
  thumbwheel:
  {
    divert: false;
    invert: false;
  };

  # Resolution/DPI
  dpi: 1280;

  buttons: (
    {
      # Back button - Copy
      cid: 0x53;
      action =
      {
        type: "Keypress";
        keys: ["KEY_LEFTCTRL", "KEY_C"];
      };
    },
    {
      # Forward button - Paste
      cid: 0x56;
      action =
      {
        type: "Keypress";
        keys: ["KEY_LEFTCTRL", "KEY_V"];
      };
    },
    {
      # Mode shift button (behind scroll wheel)
      cid: 0xc4;
      action =
      {
        type: "ToggleSmartshift";
      };
    },
    {
      # Thumb button with gestures
      cid: 0xc3;
      action =
      {
        type: "Gestures";
        gestures: (
          {
            direction: "None";
            mode: "OnRelease";
            action =
            {
              type: "Keypress";
              keys: ["KEY_LEFTMETA"];
            };
          },
          {
            direction: "Left";
            mode: "OnRelease";
            action =
            {
              type: "Keypress";
              keys: ["KEY_LEFTCTRL", "KEY_LEFTALT", "KEY_RIGHT"];  # Next workspace
            };
          },
          {
            direction: "Right";
            mode: "OnRelease";
            action =
            {
              type: "Keypress";
              keys: ["KEY_LEFTCTRL", "KEY_LEFTALT", "KEY_LEFT"];  # Previous workspace
            };
          },
          {
            direction: "Up";
            mode: "OnRelease";
            action =
            {
              type: "Keypress";
              keys: ["KEY_LEFTMETA", "KEY_D"];  # Show desktop
            };
          },
          {
            direction: "Down";
            mode: "OnRelease";
            action =
            {
              type: "Keypress";
              keys: ["KEY_LEFTMETA", "KEY_A"];  # Show applications
            };
          }
        );
      };
    }
  );
},
{
  name: "MX Master 3S";

  # SmartShift for automatic fast scrolling
  smartshift:
  {
    on: true;
    threshold: 20;
    torque: 50;
  };

  # Natural scrolling with adjusted speed
  hiresscroll:
  {
    hires: false;
    invert: true;
    target: false;
  };

  # Thumb wheel settings
  thumbwheel:
  {
    divert: false;
    invert: false;
  };

  # Resolution/DPI
  dpi: 1280;

  buttons: (
    {
      # Back button - Copy
      cid: 0x53;
      action =
      {
        type: "Keypress";
        keys: ["KEY_LEFTCTRL", "KEY_C"];
      };
    },
    {
      # Forward button - Paste
      cid: 0x56;
      action =
      {
        type: "Keypress";
        keys: ["KEY_LEFTCTRL", "KEY_V"];
      };
    },
    {
      # Mode shift button (behind scroll wheel)
      cid: 0xc4;
      action =
      {
        type: "ToggleSmartshift";
      };
    },
    {
      # Thumb button with gestures
      cid: 0xc3;
      action =
      {
        type: "Gestures";
        gestures: (
          {
            direction: "None";
            mode: "OnRelease";
            action =
            {
              type: "Keypress";
              keys: ["KEY_LEFTMETA"];
            };
          },
          {
            direction: "Left";
            mode: "OnRelease";
            action =
            {
              type: "Keypress";
              keys: ["KEY_LEFTCTRL", "KEY_LEFTALT", "KEY_RIGHT"];  # Next workspace
            };
          },
          {
            direction: "Right";
            mode: "OnRelease";
            action =
            {
              type: "Keypress";
              keys: ["KEY_LEFTCTRL", "KEY_LEFTALT", "KEY_LEFT"];  # Previous workspace
            };
          },
          {
            direction: "Up";
            mode: "OnRelease";
            action =
            {
              type: "Keypress";
              keys: ["KEY_LEFTMETA", "KEY_D"];  # Show desktop
            };
          },
          {
            direction: "Down";
            mode: "OnRelease";
            action =
            {
              type: "Keypress";
              keys: ["KEY_LEFTMETA", "KEY_A"];  # Show applications
            };
          }
        );
      };
    }
  );
}
);
LOGID_EOF

# Create systemd service file if it doesn't exist
if [ ! -f /etc/systemd/system/logid.service ]; then
    echo "→ Creating systemd service..."
    cat > /etc/systemd/system/logid.service << 'SERVICE_EOF'
[Unit]
Description=Logitech Configuration Daemon
After=multi-user.target
Wants=multi-user.target

[Service]
Type=simple
ExecStart=/usr/local/bin/logid
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure
User=root
Group=root

[Install]
WantedBy=multi-user.target
SERVICE_EOF
fi

# Reload systemd and enable service
echo "→ Enabling and starting logid service..."
systemctl daemon-reload
systemctl enable logid > /dev/null 2>&1
systemctl restart logid

echo ""
echo "✓ logiops configured successfully!"
echo ""
echo "Configuration: /etc/logid.cfg"
echo "Service: /etc/systemd/system/logid.service"
echo ""
echo "Configured for:"
echo "  • MX Master 3"
echo "  • MX Master 3S"
echo ""
echo "Button mappings:"
echo "  • Back button: Copy (Ctrl+C)"
echo "  • Forward button: Paste (Ctrl+V)"
echo "  • Thumb button: Super key (press)"
echo "  • Thumb button gestures:"
echo "    - Left: Next workspace"
echo "    - Right: Previous workspace"
echo "    - Up: Show desktop"
echo "    - Down: Show applications"
echo "  • Mode shift button: Toggle SmartShift"
echo ""
echo "Service status: systemctl status logid"
echo "Reload config: sudo systemctl restart logid"
echo ""
