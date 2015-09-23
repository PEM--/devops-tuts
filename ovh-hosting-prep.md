# OVH Hosting preparation

:warning: Under heavy construction




## VPS configuration
* **Add you SSH public key**.
  * In the OVH manager UI, under the account, add your SSH public key.
* **R-install the VPS for taking the SSH key into account**.
  * The OS selection is 'Docker Unbutu 15.04 (64 bits)'.
* **Change the root password**
  ```sh
  ssh root@FQDN
  passwd
  ```
* **Activate security updates and security services**
  ```sh
  apt-get update
  apt-get upgrade -y
  apt-get install -y ufw
  ufw allow ssh
  ufw allow smtp # Special rule for Postfix that needs to be removed once SSL certificate is bought
  ufw allow 80/tcp
  ufw allow 443/tcp
  ufw enable
  ```
* **Edit VPS's hostname**
  ```
  vi /etc/hostname
  FQDN
  :x
  reboot
  ```
* **Install the temporary email server**
  ```sh
  ssh root@FQDN
  apt-get install -y postfix mailutils
  # Choose 'Internet site'
  # Set your FQDN
  ```




```
$TTL 3600
@	IN SOA dns200.anycast.me. tech.ovh.net. (2015092201 86400 3600 3600000 300)
           IN NS     ns200.anycast.me.
           IN NS     dns200.anycast.me.
           IN A      51.254.128.22
           IN TXT    "1|www.congres-avef-snvel.fr"
www        IN A      51.254.128.22
www        IN TXT    "3|welcome"
www        IN TXT    "l|fr"
```


## Buying the certificate




### Cleaning the system

@TODO Firewall update


* **Remove temporary email server**
  ```sh
  apt-get remove --purge -y postfix mailutils
  ```

* **Clean up system**

apt-get autoremove -y
apt-get autoclean
