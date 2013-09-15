rightscale_marker :begin

log "  Adding the nospoof option to prevent IP Spoofing"

ruby_block "Prevent IP Spoofing" do
  file = Chef::Util::FileEdit.new("/etc/host.conf")
  file.insert_line_if_no_match(
    "nospoof on",
    "\n# Option to prevent IP Spoofing\nnospoof on"
  )
  file.write_file
end

rightscale_marker :end
