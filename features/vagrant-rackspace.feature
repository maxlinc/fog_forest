@announce
@vagrant-rackspace
Feature: vagrant-rackspace fog tests
  As a Fog developer
  I want to smoke (or "fog") test vagrant-rackspace.
  So I am confident my upstream changes did not create downstream problems.

  Background:
    Given I have installed vagrant-rackspace
    And I have Rackspace credentials available

  Scenario: Create a single server
    Given a file named "Vagrantfile" with:
    """
    # Include our VCR setup for testing
    # require File.expand_path('../../../vcr.rb', __FILE__)

    Vagrant.configure("2") do |config|
      # dev/test method of loading plugin, normally would be 'vagrant plugin install vagrant-rackspace'
      Vagrant.require_plugin "vagrant-rackspace"

      config.vm.box = "dummy"
      config.ssh.private_key_path = "~/.ssh/id_rsa"

      config.vm.provider :rackspace do |rs|
        rs.username = ENV['RAX_USERNAME']
        rs.api_key  = ENV['RAX_API_KEY']
        rs.flavor   = /512MB/
        rs.image    = /Ubuntu/
        rs.public_key_path = "~/.ssh/id_rsa.pub"
      end
    end
    """
    When I successfully run `bundle exec vagrant up --provider rackspace`
    And I get the server from "Instance ID:"
    Then the server should be active
