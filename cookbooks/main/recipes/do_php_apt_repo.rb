apt_repository "php5" do
  uri "http://ppa.launchpad.net/rip84/php5/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "EE379B61"
end
