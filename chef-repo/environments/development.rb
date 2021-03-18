name "development"
description "The master development branch"
cookbook_versions({
    "nginx" => ">= 0.1.3"
    #"apt" => "= 0.0.1"
})

override_attributes ({
    "nginx" => {
        "listen" => [ "80", "443" ]
    },
    "mysql" => {
        "root_pass" => "root"
    }
})