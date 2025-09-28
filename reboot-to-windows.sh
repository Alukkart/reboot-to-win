#!/bin/bash

if [ -t 0 ]; then
    # CLI - sudo
    SUDO_CMD="sudo"
else
    # GUI - pkexec
    SUDO_CMD="pkexec"
fi

WINDOWS_BOOT_NUM=$(efibootmgr | grep -i windows | grep -oP 'Boot\K[0-9]+')

if [ -n "$WINDOWS_BOOT_NUM" ]; then
    if $SUDO_CMD efibootmgr -n "$WINDOWS_BOOT_NUM"; then
        if command -v zenity >/dev/null 2>&1 && [ ! -t 0 ]; then
            systemctl reboot
        else
            echo "Success! Windows will load on next reboot."
            read -p "Reboot now? (y/N): " answer
            if [[ $answer == [Yy] ]]; then
                $SUDO_CMD systemctl reboot
            fi
        fi
    else
        ERROR_MSG="Error: faild to set Windows boot entry"
        echo "$ERROR_MSG"
        [ ! -t 0 ] && zenity --error --text="$ERROR_MSG"
    fi
else
    ERROR_MSG="Windows boot entry not found!\n\nAvailable entries:\n$(efibootmgr)"
    echo "$ERROR_MSG"
    [ ! -t 0 ] && zenity --error --text="$ERROR_MSG"
fi
