# Ruby Web Server Cookbook


## VPS Provisioning
This cookbook is designed to make setting up a Ruby web server on a VPS quite simple.  

I recommend using [Digital Ocean](https://www.digitalocean.com/).  

The cookbook will install the following stack:
* Ruby 2.0 
* rbenv
* PostgreSQL
* Apache2
* Phusion Passenger
* Node.js
* ImageMagick


### Setup


#### Install gems
````
gem install knife-solo
gem install berkshelf
````


#### Setup kitchen


##### Init
````
knife solo init vps-provisioner
berks init vps-provisioner
cd vps-provisioner
````


##### Gemfile
````
source 'https://rubygems.org'

gem 'knife-solo'
gem 'berkshelf'
````


##### Berksfile
````
site :opscode

cookbook 'ruby_web_server', git: 'git@github.com:rossjourdain/ruby_web_server_cookbook.git'
````


##### Install Gems and Cookbooks
````
bundle install
berks install --path cookbooks
````


### Build a Ruby web server

#### Install Chef
````
knife solo prepare <user>@<server>
````

#### Upload cookbooks and run them
````
knife solo cook <user>@<server>
````

## Requirements
TODO

## Usage
TODO

## Attributes
TODO

## Recipes
TODO

## Author
TODO

Author:: Ross Jourdain
