Given(/^I have installed (.*)$/) do | sdk |
  @dirs = ["sdks/#{sdk}"]
  steps %Q{
    And I run `bash bootstrap.sh`
  }
end

# This is to use projects like paperclip_demo as-in, without introducing a bootstrap.sh file
Given(/^I have bundled (.*)$/) do | sdk |
  @dirs = ["sdks/#{sdk}"]
  steps %Q{
    And I run `bundle install --quiet`
  }
end

Given(/^I have Rackspace credentials available$/) do
  fail unless ENV['RAX_USERNAME'] && ENV['RAX_API_KEY']
end

Given(/^I am setup to run example code for (.*)$/) do | sdk |
  @dirs = ["sdks/#{sdk}"]
  steps %Q{
    And I run `bash bootstrap.sh`
  }
end

When(/^I execute the following code:$/) do |string|
  steps %Q{
    Given a file named "#{@scenario}.txt" with:
    """
    #{string}
    """
    When I run `bash -c 'cat #{@scenario}.txt | ./run.sh'` interactively
    Then the exit status should be 0
  }
end

Given(/^I set:$/) do |table|
  table.hashes.each do |hash|
    hash.each_pair do |key, value|
      ENV[key] = value
    end
  end
end