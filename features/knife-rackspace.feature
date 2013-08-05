@announce
@knife-rackspace
Feature: knife-rackspace fog tests
  As a Fog developer
  I want to smoke (or "fog") test knife-rackspace.
  So I am confident my upstream changes did not create downstream problems.

  Background:
    Given I have installed knife-rackspace
    And I have Rackspace credentials available

  Scenario: List Flavors
    When I successfully run `bundle exec knife rackspace flavor list`
    # Having trouble with multiline contains
    Then the output should contain:
    """
8   30GB Standard Instance   8      30720  1200 GB
    """

  Scenario: List Images
    When I successfully run `bundle exec knife rackspace image list`
    Then the output should contain:
    """
Ubuntu 12.04
    """

  Scenario: List Networks
    When I successfully run `bundle exec knife rackspace network list`
    Then the output should match:
    """
    public\s*00000000-0000-0000-0000-000000000000
    """

  @network
  Scenario: Create a Network
    When I successfully run `bundle exec knife rackspace network create -L test-network -C 10.0.0.0/24`
    Then the output should contain:
    """
    Label: test-network
    CIDR: 10.0.0.0/24
    """

  @network
  Scenario: Delete a Network
    Given I have a network available
    When I successfully run `bash -c 'bundle exec knife rackspace network delete -y $network'`
    Then the output should contain "Deleted network"


  @slow
  Scenario: Create a Server
    When I successfully run `bundle exec knife rackspace server create -c knife.rb --rackspace-version 2 -I e4dbdba7-b2a4-4ee5-8e8f-4595b6d694ce -f 2 -N knife-rackspace-server`
    And I get the server from "Instance ID:"
    Then the server should be active
