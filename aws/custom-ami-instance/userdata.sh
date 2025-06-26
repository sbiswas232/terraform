#!/bin/bash

sudo apt-get update
sudo apt install apache2 -y
systemctl start apche2
systemctl enable apache2
echo "<html><h1>Apache WebServer running on-$(hostname)</h1></html" > var/www/html/index.html