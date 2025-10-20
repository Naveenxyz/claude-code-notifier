# Claude Code Enhanced Notification System

<div align="center">

**Smart, click-to-focus notifications that transform Claude Code into a seamlessly integrated development tool**

[![macOS](https://img.shields.io/badge/macOS-000000?style=flat&logo=apple&logoColor=white)](https://www.apple.com/macos/)
[![Terminal](https://img.shields.io/badge/Terminal-4D4D4D?style=flat&logo=gnometerminal&logoColor=white)](https://support.apple.com/guide/terminal/)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-FF6B35?style=flat)](https://docs.anthropic.com/en/docs/claude-code)

![Demo Notifications](https://github.com/user-attachments/assets/f2491fe5-93e3-4793-a5c0-f422002d0218)


*Beautiful, context-aware notifications with click-to-focus functionality*

</div>

## ✨ Features

- 🎯 **Click-to-Focus**: Click any notification to instantly return to your IDE or terminal
- 🧠 **Context-Aware**: Shows project name and originating application
- 👀 **Focus-Smart**: Only notifies when you've switched away from your work
- 🎨 **Beautiful UI**: Professional notifications with titles, subtitles, and sounds
- ⚡ **Multi-App Support**: Works with 10+ popular development applications
- 🖥️ **Tmux Support**: Full detection support for terminal multiplexer sessions
- 🔧 **Easy Setup**: One-command installation with automatic configuration

## 🚀 Quick Setup

### Option 1: Clone and Install (Recommended)

```bash
# Clone the repository
git clone https://github.com/Naveenxyz/claude-code-notifier.git

# Run the installer (it will automatically setup in ~/.claude-notifications)
cd claude-code-notifier
./install.sh
```

### Option 2: Custom Installation Directory

```bash
# Clone the repository
git clone https://github.com/Naveenxyz/claude-code-notifier.git
cd claude-code-notifier

# Install to custom directory
CLAUDE_NOTIFICATIONS_DIR="~/my-custom-path" ./install.sh
```

### Option 3: Direct Download

```bash
# Create temporary directory
mkdir -p /tmp/claude-notifications && cd /tmp/claude-notifications

# Download the scripts
curl -O https://raw.githubusercontent.com/Naveenxyz/claude-code-notifier/main/config.sh
curl -O https://raw.githubusercontent.com/Naveenxyz/claude-code-notifier/main/common.sh
curl -O https://raw.githubusercontent.com/Naveenxyz/claude-code-notifier/main/notify-completion.sh
curl -O https://raw.githubusercontent.com/Naveenxyz/claude-code-notifier/main/notify-handler.sh
curl -O https://raw.githubusercontent.com/Naveenxyz/claude-code-notifier/main/install.sh

# Run the installer
./install.sh
```

That's it! 🎉 The installer will:
- Install dependencies (`jq` and `terminal-notifier`)
- Copy scripts to `~/.claude-notifications` (or your custom directory)
- Configure Claude Code hooks automatically
- Test notification permissions
- Set up everything for immediate use

**Default Installation Location**: `~/.claude-notifications`  
**Custom Installation**: Set `CLAUDE_NOTIFICATIONS_DIR` environment variable

### ✅ Verify Installation

Test that everything is working correctly:

```bash
# Run the system verification script
~/.claude-notifications/test-system.sh
```

This will check all dependencies, test the notification system, and verify the installation.

## 🔧 Manual Configuration

If you prefer manual setup, add this to your `~/.claude/settings.json`:

```json
{
  "hooks": {
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude-notifications/notify-handler.sh"
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude-notifications/notify-completion.sh"
          }
        ]
      }
    ]
  }
}
```

## 🏗️ Architecture

### Core Scripts

- **`config.sh`** - Configuration and path management for flexible installation
- **`common.sh`** - Shared utilities and functions used by all scripts
- **`notify-completion.sh`** - Handles task completion notifications  
- **`notify-handler.sh`** - Handles explicit notifications (permissions, etc.)
- **`install.sh`** - Automated setup and configuration

### How It Works

1. **Tmux Detection**: First checks if running inside tmux and detects the terminal emulator
2. **Process Detection**: Walks up the process tree to identify the originating application
3. **Focus Monitoring**: Uses AppleScript to detect the currently focused app
4. **Smart Logic**: Only sends notifications when you've switched away from your work
5. **Enhanced Delivery**: Uses `terminal-notifier` for professional notifications
6. **Click Handling**: Bundle IDs enable click-to-focus functionality

## 📱 Supported Applications

| Category | Applications |
|----------|-------------|
| **IDEs** | IntelliJ IDEA, Cursor, VS Code, WebStorm, PHPStorm, PyCharm, Sublime Text |
| **Terminals** | Terminal, iTerm2, Ghostty, Alacritty, Warp |
| **Terminal Multiplexers** | Tmux (with full terminal detection support) |
| **Others** | Any application (basic support) |

## 🔍 Debugging

View real-time logs to troubleshoot any issues:

```bash
tail -f ~/.claude-notifications/debug.log
```

The logs show detailed information about:
- Hook triggers and JSON input
- App detection and focus analysis  
- Notification commands and outputs
- Success/skip decisions

**Auto Log Rotation**: The log file automatically rotates when it reaches 10,000 lines, keeping only the most recent 5,000 lines to prevent unlimited growth.

## ⚙️ Customization

### Adding New Applications

1. **Add Process Detection**: Edit `~/.claude-notifications/common.sh` in the `detect_originating_app()` function
2. **Add Bundle ID**: Edit `~/.claude-notifications/common.sh` in the `get_bundle_id()` function  
3. **Test**: Verify with `terminal-notifier -activate "your.bundle.id"`

### Customizing Notifications

Edit the notification functions in `common.sh`:
- **Sounds**: Change `"Hero"` to other macOS sounds (`"Glass"`, `"Ping"`, `"Pop"`, etc.)
- **Timing**: Modify the focus detection logic
- **Content**: Customize message formatting and context

### Example: Adding Zed Editor

```bash
# In common.sh, add to detect_originating_app():
*"zed"*) echo "zed"; return ;;

# Add to get_bundle_id():  
"zed") echo "dev.zed.Zed" ;;
```

## 🎨 Notification Types

### Completion Notifications
- **Trigger**: When Claude Code finishes a conversation
- **Content**: "Claude has finished running in [project]"
- **Action**: Click to return to your IDE/terminal

### Handler Notifications  
- **Trigger**: Explicit notifications (permission requests, etc.)
- **Content**: Original message with project context
- **Action**: Click to return to your IDE/terminal

## 🔒 Security & Privacy

- Scripts run with your user permissions only
- No sensitive data is transmitted or stored
- Only reads system process information
- All operations are local to your machine

## 🐛 Troubleshooting

### Notifications Not Appearing
1. Check terminal-notifier permissions in System Settings → Notifications
2. Verify scripts are executable: `ls -la ~/.claude-notifications/`
3. Check logs: `tail ~/.claude-notifications/debug.log`

### Click-to-Focus Not Working
1. Verify bundle IDs: `osascript -e 'id of app "YourApp"'`
2. Test manually: `terminal-notifier -activate "bundle.id" -message "test"`
3. Check app is running when notification appears

### Dependencies Missing
```bash
# Install jq
brew install jq

# Install terminal-notifier  
brew install terminal-notifier
```

## 💡 Tips & Tricks

- **Multi-Project Workflow**: Works seamlessly across different projects
- **IDE Integration**: Launch Claude from your IDE for best experience  
- **Terminal Sessions**: Perfect for long-running terminal operations
- **Focus Flow**: Switch apps freely - notifications appear when needed

## 🤝 Contributing

Found a bug or want to add support for a new application? Contributions welcome!

1. Fork the repository
2. Add your changes to the appropriate script in `common.sh`
3. Test thoroughly with your target application
4. Submit a pull request with clear description

## 📄 Requirements

- **macOS** (uses AppleScript for app detection)
- **jq** (JSON processing)
- **terminal-notifier** (enhanced notifications)
- **Claude Code** with hooks enabled

---

<div align="center">

**Transform your Claude Code experience today! 🚀**

*Made with ❤️ for productive developers*

</div>
