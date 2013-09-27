# Ruby Web Server Cookbook


## VPS Provisioning
This cookbook is designed to make setting up a Ruby web server on a VPS using Chef quite simple.  
To use the cookbook, it's best to use Matt Schaffer's 
<a href='http://matschaffer.github.com/knife-solo/' target='_blank'>Knife Solo</a> using the instructions below.

I recommend using <a href='https://www.digitalocean.com/' target='_blank'>Digital Ocean</a>.  

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
## ./Gemfile

source 'https://rubygems.org'

gem 'knife-solo'
gem 'berkshelf'
````


##### Berksfile
````
## ./Berksfile

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

#### Setup the server config 
````
## ./nodes/<server>.json
{
  "run_list": [
    "ruby_web_server"
  ],
  "users": {
    "deploy": {
      password: '$6$Jz61tUIPAEBc4R69$.77ruWIRf36yQ9ySPL2qObbu54jduoCCMUDb.28khUr95YYnuj5AKhslLnGAqSPBEolHC5MNm0yAExSoC6FKy.',  # mkpasswd -m sha-512 deploy
      ssh_keys: [''],
    },
  },
  "locale": {
    "lang": "en_NZ.utf8"
  },
  "postgresql": {
    "password": {
      "postgres": "postgres"
    }
  }
}
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
<a href='https://github.com/rossjourdain/' target='_blank'>Ross Jourdain</a>

