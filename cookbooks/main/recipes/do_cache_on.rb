ruby_block "Turn CE Cache On" do
  block do
    file = Chef::Util::FileEdit.new("/var/www/newspring.cc/hello/expressionengine/config/config.php")
    file.search_file_delete_line(
      "$config['ce_cache_off']"
    )
    file.write_file
  end
end
