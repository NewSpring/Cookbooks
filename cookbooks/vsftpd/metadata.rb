maintainer       "Gerhard Lazu"
maintainer_email "gerhard@lazu.co.uk"
license          "Apache License, Version 2.0"
description      "Installs/Configures vsftpd for Secure SSL SFTP"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.4.1"

recipe "vsftpd::default", "Installs VSFTPD"
recipe "vsftpd::chroot_users", "Chroot users to directory"
recipe "vsftpd::ssl", "Install SSL certs"
