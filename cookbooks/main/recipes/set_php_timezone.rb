ruby_block "Set PHP TimeZone" do
  block do
    file = Chef::Util::FileEdit.new("/etc/php5/apache2/php.ini")
    file.search_file_replace_line(
      ";date.timezone =", "date.timezone = America/New_York"
    )
    file.write_file
  end
end
