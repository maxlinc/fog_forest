When(/^I get the server from "(.*?)"$/) do |label|
  @server_id = all_output.match(/#{label}\s(\w*)/)[1]
end

When(/^I load the server$/) do
  @server_id = all_output.strip.lines.to_a.last
  puts "Server: #{@server_id}"
end

Then(/^the server should be active$/) do
  server = @compute.servers.get @server_id
  server.state.should == 'ACTIVE'
end
