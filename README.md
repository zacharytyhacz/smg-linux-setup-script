# smg-linux-setup-script
Linux server init script to quickly get things setup.

# Note
This script expects to be on **Ubuntu** and that you are the **root user** and have not done anything initially to your server yet.

# What it does
- Sets up an `admin` user automatically with `sudo` permissions ( asks you for password )
- Removes root login from ssh
- Removes password authentication
- Setups `authorized_keys` for the `admin` user prompting you to add ssh keys
- Changes ssh port to optionally given `SSH_PORT` var
- Adds initial banner for ssh
- Adds `ufw` and setups initial port access
- Adds automatic cronjob updates
- Sets up correct east coast time zone


# Run
```bash
# as root user...
curl https://raw.githubusercontent.com/zacharytyhacz/smg-linux-setup-script/master/linux_setup_script.sh > setup.sh
chmod +x setup.sh
SSH_PORT=123456 setup.sh
```
