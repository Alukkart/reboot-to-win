# Reboot to windows script

A simple bash script that automatically detects and sets Windows as the next boot option in UEFI systems. The script intelligently chooses between CLI (`sudo`) and GUI (`pkexec`) authentication methods based on how it's executed.

## Features

- **Automatic Windows Boot Entry Detection**: Scans EFI boot entries to find Windows
- **Dual Authentication Support**:
  - Uses `sudo` when run from terminal
  - Uses `pkexec` (GUI) when run from file manager
- **User-Friendly Notifications**:
  - Terminal prompts for CLI execution
  - Zenity dialogs for GUI execution
- **Automatic Reboot**: Option to reboot immediately after setting boot order

## Prerequisites

- **UEFI System**: This script only works on UEFI-based systems
- **efibootmgr**: Required for managing EFI boot entries
- **zenity**: For GUI notifications (optional, auto-detected)
- **sudo** or **pkexec**: For privilege escalation

### Installation Dependencies

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install efibootmgr zenity
```

**Fedora/RHEL:**
```bash
sudo dnf install efibootmgr zenity
```

**Arch Linux:**
```bash
sudo pacman -S efibootmgr zenity
```

## Usage

### CLI Usage (Terminal)
```bash
chmod +x windows-boot-selector.sh
./windows-boot-selector.sh
```

### GUI Usage (File Manager)
Double-click the script in your file manager. It will:
1. Request administrator privileges via `pkexec`
2. Show progress with Zenity dialogs
3. Offer to reboot automatically

## How It Works

1. **Detection**: Script scans `efibootmgr` output for Windows boot entries
2. **Authentication**: Chooses between `sudo` (CLI) or `pkexec` (GUI)
3. **Execution**: Sets Windows as next boot option using `efibootmgr -n`
4. **Notification**: Informs user and offers reboot option

## Example Output

### Successful Execution (CLI):
```
Success! Windows will load on next reboot.
Reboot now? (y/N):
```

### Error Handling:
- Shows appropriate error messages if Windows boot entry not found
- Displays available boot entries for troubleshooting

## Troubleshooting

### Common Issues:

1. **"Windows boot entry not found"**
   - Ensure Windows is installed in UEFI mode
   - Check if EFI partition is properly mounted
   - Verify Windows boot manager exists in EFI

2. **Permission Denied**
   - Ensure you have necessary privileges
   - Install `pkexec` for GUI execution

3. **efibootmgr not found**
   - Install efibootmgr package for your distribution

### Manual Boot Entry Check:
```bash
efibootmgr -v
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## Disclaimer

Use this script at your own risk. The authors are not responsible for any system instability or boot issues that may occur. Always ensure you have important data backed up before modifying boot settings.
