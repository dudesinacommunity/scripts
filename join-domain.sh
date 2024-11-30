echo "- Setting timezone"
timedatectl set-timezone Europe/Oslo

echo "- Installing packages"
apt-get install realmd sssd sssd-tools libnss-sss libpam-sss adcli samba-common-bin oddjob oddjob-mkhomedir packagekit -y > /dev/null

echo "- Enabling password login"
sudo sed -E -i 's/^#?PasswordAuthentication (no|yes)/PasswordAuthentication yes/' /etc/ssh/sshd_config && sudo systemctl restart sshd

read "Domain: " AD_DOMAIN
read "Username: " AD_USERNAME

echo "- Joining domain"
realm join --membership-software=samba --client-software=sssd --user="$AD_USERNAME" "$AD_DOMAIN"

echo "- Enabling mkhomedir"
pam-auth-update --enable mkhomedir