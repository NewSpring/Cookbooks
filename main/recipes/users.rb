#
# Cookbook Name:: main
# Recipe:: default
#
# Copyright 2012, NewSpring Church
#
# All rights reserved - Do Not Redistribute
#
#This is a recipe to run LWRP's to configure different aspects of a server.
#
users = data_bag("users")
users.each do |user|
  u = data_bag_item("users", user)
  if u['home'] != "/dev/null"
    execute "chsh" do
      command "chsh -s `which zsh`"
      environment ({ 'HOME' => "#{u['home']}"})
    end
  end
end


