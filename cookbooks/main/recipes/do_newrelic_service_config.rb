node['newrelic-ng']['plugin-agent']['service_config'] = <<-EOS
apache_httpd:
    name: localhost
    scheme: http
    host: localhost
    port: 80
    path: /server-status
memcached:
    name: memcached_saas
    host: memcached.private
php_apc:
    scheme: http
    host: localhost
    port: 80
EOS

