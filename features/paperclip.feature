@announce
@paperclip
Feature: paperclip fog tests
  As a Fog developer
  I want to smoke (or "fog") test paperclip.
  So I am confident my upstream changes did not create downstream problems.

  Background:
    Given I have bundled paperclip_demo
    And I have Rackspace credentials available
    And I set:
    | key       | value     |
    | RAILS_ENV | rackspace |

  Scenario: Paperclip sample app on Heroku
    Given the container "paperclip_demo_rackspace" does not exist
    When I successfully run `bundle exec rake db:create db:migrate assets:precompile`
    When I successfully run `bundle exec rspec spec/acceptance`
    Then the container "paperclip_demo_rackspace" should contain a file matching /original/mona_lisa.jpg/
