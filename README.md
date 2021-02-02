# dotfiles
A place to store my configuration files

# Background

I've been coding since the 90s. Over that time I've created many different notes, files and templates that I've stashed all over the place.

Since the late 2010s, I've been doing most of my programming on a Windows 10 machine, running Ubuntu installations inside of [WSL - the Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10).  While manually going thru my notes and upgrading them can be nostalgic, it isn't the most efficient use of my time.

This repo will hopefully be a living compendium of what I've done...and how it can be replayed.  Either by friends, strangers, or my when I need to quickly initialize a new machine just the way I like it.

# Next Steps

## Fresh Windows Machine

(Will do this in conjunction w/ a new build)

## Fresh WSL Environments

1. Fire up a distro (in my case, Ubuntu) via WSL and sign in for the first time, and create a password
2. Copy and paste these 2 lines into your Linux command prompt.

```
# Create the wsl conf file
bash <(curl -s https://raw.githubusercontent.com/markcerv/dotfiles/main/wsl/000-create-wsl-conf.sh)

# Update packages
bash <(curl -s https://raw.githubusercontent.com/markcerv/dotfiles/main/wsl/010-update-unbuntu.sh)

# Modify ssh settings
bash <(curl -s https://raw.githubusercontent.com/markcerv/dotfiles/main/wsl/012-modify-sshd-config.sh)
```

3. View the [dotfiles/wsl/020-terminate-wsl.bat](https://github.com/markcerv/dotfiles/blob/main/wsl/020-terminate-wsl.bat) and then run these DOS commands

```
@REM  This will show you ALL of your installed distros:
wsl -l --all

@REM  Replace Ubunuto-20.04 with the distro that you want to terminate
wsl -t Ubuntu-20.04
```

4. Restart WSL however you normally do it.

5. You should now be able to SSH to 127.0.0.1 port 2220 (or whatever you set in) using the username and password that you configured in step 1.
