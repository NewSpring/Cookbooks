rightscale_marker :begin

ruby_block "Hardening PHP Settings..." do
  block do
    file = Chef::Util::FileEdit.new("/etc/php5/apache2/php.ini")
    file.search_file_replace_line("expose_php = On", "expose_php = Off")
    file.write_file
  end
end

rightscale_marker :end
