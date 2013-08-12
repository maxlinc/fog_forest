# require File.expand_path('../../../vcr.rb', __FILE__)
config_dir = "#{ENV['HOME']}/.chef"
log_level                :info
log_location             STDOUT
node_name                "#{ENV['RAX_USERNAME']}"
client_key               "#{config_dir}/#{ENV['RAX_USERNAME']}.pem"
validation_client_name   "rackspace_test-validator"
validation_key           "#{config_dir}/rackspace_test-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/rackspace_test"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{config_dir}/../cookbooks"]

knife[:rackspace_api_username] = "#{ENV['RAX_USERNAME']}"
knife[:rackspace_api_key] = "#{ENV['RAX_API_KEY']}"
knife[:rackspace_region] = "#{ENV['RAX_REGION'].downcase}"
