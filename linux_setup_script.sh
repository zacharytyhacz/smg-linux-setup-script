######################################
# smg mobile gett rektt init linux script

# note: this expects to be on ubuntu

apt update
apt upgrade -y

adduser admin
# asks for password

usermod -aG sudo admin



######################################
# ssh setup


# turn root login off
sed --in-place=_bak 's/PermitRootLogin\ yes/PermitRootLogin\ no/g' /etc/ssh/sshd_config

# turn off password auth
sed --in-place=_bak 's/PasswordAuthentication\ yes/PasswordAuthentication\ no/g' /etc/ssh/sshd_config

# default SSH port to 22 if not set
if [ -z "$SSH_PORT" ]; then SSH_PORT=22 ; else echo "SSH_PORT=$SSH_PORT"; fi

# change port
echo "Port $SSH_PORT" >> /etc/ssh/sshd_config

# add $HOME/.ssh/authorized_keys as the authorized keys file
echo "AuthorizedKeysFile     .ssh/authorized_keys" >> /etc/ssh/sshd_config

# add a banner
echo "SMG MOBILE" > /etc/ssh/banner
echo "Banner /etc/ssh/banner" >> /etc/ssh/sshd_config

# add ssh key data to the admin user
mkdir /home/admin/.ssh
chown admin:admin /home/admin/.ssh

echo "# add your public ssh key(s) here for the admin user" > /home/admin/.ssh/authorized_keys
nano /home/admin/.ssh/authorized_keys
chown admin:admin /home/admin/.ssh/authorized_keys


######################################
# fire wall set up

# add uncomplicated fire wall package
apt install ufw -y

# ssh
ufw deny in 22
ufw allow out 22

# special ssh port
ufw allow in $SSH_PORT
ufw allow out $SSH_PORT

ufw allow in http 
ufw allow out http

ufw allow in https
ufw allow out https

# to be added
# ufw limit 80/tcp
# ufw limit 443/tcp

ufw enable

######################################
# fail2ban - to be added


###########################################################
# automatic restart and updates cron job ( sunday at 6am )

echo "0 5 * * 0 root bash (apt update && apt -y upgrade && /sbin/shutdown -r now) > /dev/null" > /etc/cron.d/updates


##############################################################
# set eastern time                    

timedatectl set-timezone America/New_York

reboot
