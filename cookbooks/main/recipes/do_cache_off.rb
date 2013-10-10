ruby_block "Turn CE Cache Off" do
  block do
    file = Chef::Util::FileEdit.new("/var/www/newspring.cc/hello/expressionengine/config/config.php")
    file.insert_line_if_no_match(
      "$config['ce_cache_off']",
      "$config['ce_cache_off'] = 'yes';"
    )
    file.write_file
  end
end
