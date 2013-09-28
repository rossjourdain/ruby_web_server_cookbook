#
# Cookbook Name:: ruby_web_server
# Recipe:: default
#
# Copyright 2013, Ross Jourdain
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


## Update packages
include_recipe "apt::default"


## Language packs
package "language-pack-en-base"


## Locale
include_recipe "locale"


## User
node[:users].each do |user, user_data|
  user_account user do
    password user_data[:password]
    ssh_keys user_data[:ssh_keys]
  end
end


## Application Directory
directory "/var/apps" do
     owner "deploy"
     group "deploy"
  mode 00744
     action :create
end

## Webapp directories
node[:webapps].each do |webapp, webapp_data|
  directory "/var/apps/#{webapp}" do
    owner "deploy"
    group "deploy"
    mode 00744
    action :create
  end

  directory "/var/apps/#{webapp}/releases" do
    owner "deploy"
    group "deploy"
    mode 00744
    action :create
  end

  directory "/var/apps/#{webapp}/releases/initial" do
    owner "deploy"
    group "deploy"
    mode 00744
    action :create
  end

  directory "/var/apps/#{webapp}/releases/initial/public" do
    owner "deploy"
    group "deploy"
    mode 00744
    action :create
  end

  link "/var/apps/#{webapp}/current" do
    to "/var/apps/#{webapp}/releases/initial"
    owner "deploy"
    group "deploy"
    action :create
  end
end


## Postgres
include_recipe "postgresql::server"


## Ruby
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

default_ruby_version = "2.0.0-p247"

rbenv_ruby default_ruby_version do
  global true
end

rbenv_gem "bundler" do
  ruby_version default_ruby_version
end


## Apache + Passenger + Rails
include_recipe "rails"
include_recipe "passenger_apache2"

node[:webapps].each do |webapp, webapp_data|
  web_app webapp do
    docroot "/var/apps/#{webapp}/current/public"
    server_name "#{webapp}.#{webapp_data[:domain]}"
    server_aliases [webapp, node[:hostname]]
    rails_env webapp_data[:rails_env]
  end
end


## Nodejs
include_recipe "nodejs"


## ImageMagick
include_recipe "imagemagick"

