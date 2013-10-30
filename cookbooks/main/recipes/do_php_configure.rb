rightscale_marker :begin

ruby_block "Update the Upload and POST file Size" do
  block do
    file = Chef::Util::FileEdit.new("/etc/php5/apache2/php.ini")
    file.search_file_replace_line(
      "upload_max_filesize = 2M",
      "upload_max_filesize = 512M"
    )
    file.write_file

    file.search_file_replace_line(
      "post_max_size = 8M",
      "post_max_size = 512M"
    )
    file.write_file
  end
end

rightscale_marker :end
