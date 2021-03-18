name "web_server"
description "A role to configure our front-line web servers"
run_list "recipe[apt]", "recipe[nginx]"
env_run_lists "production" => ["recipe[nginx::config_prod]"], "testing" => ["recipe[nginx::config_test]"], "_default" => []
default_attributes "nginx" => { "log_location" => "/var/log/nginx.log" }
override_attributes "nginx" => { "gzip" => "on" }
