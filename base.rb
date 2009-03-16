has_authentication = yes?("Should this project have an authentication support?")

# All about gems.
gem "authlogic" if has_authentication
gem "cucumber"

# All about plugins.
plugin "rspec", :git => "git://github.com/dchelimsky/rspec.git"
plugin "rspec-rails", :git => "git://github.com/dchelimsky/rspec-rails.git"

# Installing gems.
rake "gems:install", :sudo => true

# Needed rakes
rake "features"

# Needed generates
generate :rspec

# 

# Generating home.
run "rm public/index.html"
generate :controller, "home"
route "map.root :controller => :home"

# Model about auth.
generate :model, "user", "login:string", "crypted_password:string", "password_salt:string", "persistence_token:string", "login_count:integer", "last_request_at:datetime", "last_login_at:datetime", "current_login_at:datetime", "last_login_ip:string", "current_login_ip:string" if has_authentication

# Migrations.
rake "db:migrate" if yes?("Should perform migrations?")

# All about git.
git :init
git :add => "."
git :commit => "-a -m 'Initial commit.'"
