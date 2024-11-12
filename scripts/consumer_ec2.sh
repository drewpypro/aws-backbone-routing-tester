#!/bin/bash

# Fetch public IP
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

# Fetch region
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')

sudo hostnamectl set-hostname $PUBLIC_IP
sudo hostnamectl 

# Update /etc/hosts
echo "127.0.0.1   $HOSTNAME" | sudo tee -a /etc/hosts

# Ensure the hostname is applied immediately for the current session
export PS1="[\u@$HOSTNAME \W]\$ "

mkdir -p /home/ec2-user/.ssh
echo '${public_key}' >> /home/ec2-user/.ssh/authorized_keys
chown -R ec2-user:ec2-user /home/ec2-user/.ssh
chmod 700 /home/ec2-user/.ssh
chmod 600 /home/ec2-user/.ssh/authorized_keys

sudo rm /usr/lib/motd.d/10-uname
sudo rm /usr/lib/motd.d/20-*  # Remove any other MOTD scripts

sudo sed -i 's/#PrintLastLog yes/PrintLastLog no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

ASCII_ART='  ______   __       __   ______  
 /      \ |  \  _  |  \ /      \ 
|  $$$$$$\| $$ / \ | $$|  $$$$$$\
| $$__| $$| $$/  $\| $$| $$___\$$
| $$    $$| $$  $$$\ $$ \$$    \ 
| $$$$$$$$| $$ $$\$$\$$ _\$$$$$$\
| $$  | $$| $$$$  \$$$$|  \__| $$
| $$  | $$| $$$    \$$$ \$$    $$
 \$$   \$$ \$$      \$$  \$$$$$$ '

{
  echo ""
  echo "$ASCII_ART"    
  echo "Unauthorized prohibited, logout now."
  echo ""
} | sudo tee /usr/lib/motd.d/30-banner

sudo systemctl daemon-reload

sudo yum update -y
sudo yum install -y python3 python3-pip traceroute nc

cat <<'EOF' > /tmp/ip_toucher.py
${toucher_script}
EOF

sed -i "s|IP_LIST|${IP_LIST}|g" /tmp/ip_toucher.py
chmod +x /tmp/ip_toucher.py
sleep 60
python3 /tmp/ip_toucher.py > /tmp/ip_touchlog.txt 2>&1
