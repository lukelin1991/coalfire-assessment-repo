#!/bin/bash
# Update and install Apache on ubuntu (script)
apt update -y
apt install -y apache2

# Enable and start Apache
systemctl enable apache2
systemctl start apache2

# creating html to say something
echo "<h1>Hello with apache from ASG $(hostname)</h1>" > /var/www/html/index.html