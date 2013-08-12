@announce
@rumm
Feature: rumm fog tests
  As a Fog developer
  I want to smoke (or "fog") test rumm.
  So I am confident my upstream changes did not create downstream problems.

  Background:
    Given I have installed rumm
    And I have Rackspace credentials available

  # No flavors?
  @pending
  Scenario: List Flavors
    When I successfully run `bundle exec rumm flavor list`
    Then the output should contain:
    """
8   30GB Standard Instance   8      30720  1200 GB
    """

  Scenario: List Images
    When I successfully run `bundle exec rumm show images`
    Then the output should contain:
    """
Ubuntu 12.04
    """

  # No networks?
  @pending
  Scenario: List Networks
    When I successfully run `bundle exec rumm show networks`
    Then the output should match:
    """
    public\s*00000000-0000-0000-0000-000000000000
    """

  @slow
  @creates_server
  Scenario: Create a Server
    When I successfully run `bundle exec rumm create server -i e4dbdba7-b2a4-4ee5-8e8f-4595b6d694ce -f 2 -n rumm-server`
    And I get the server from "id:"
    Then the server should be active

