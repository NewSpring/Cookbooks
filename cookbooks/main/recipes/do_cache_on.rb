ruby_block "Turn CE Cache On" do
  block do
    file = Chef::Util::FileEdit.new("/var/www/newspring.cc/hello/expressionengine/config/config.php")
    file.search_file_replace_line(
      "$config['ce_cache_off'] = 'yes';",
      " "
    )
    file.write_file
  end
end
