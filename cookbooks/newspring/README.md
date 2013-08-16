#NewSpring Church Site Cookbook

##Description

This is a Chef cookbook to install and configure a Rackspace cloud server running 10.04 Ubuntu with the latest version of the NewSpring Website (Expression Engine).  It has only been tested on Ubuntu 10.04.

##Requirements

- Application Cookbook
- Application PHP Cookbook
- Git

##Attributes

- `[:newspring][:hostname]` : MySQL Hostname
- `[:newspring][:username]` : MySQL Username
- `[:newspring][:password]` : MySQL Password
- `[:newspring][:database]` : EE MySQL Database Password
- `[:newspring][:branch]` : Git Branch
- `[:newspring][:deploy_key]` : Github Deploy Key

##Usage

There are two recipes, `default` which install the the base essentials for the server to function and `update` which updates the site to the latest revision. Future revisons of this cookbook will incorporate a Chef LWRP to install NewSpring Sites as needed.   

