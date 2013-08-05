Given(/^I have a network available$/) do
  network = @compute.networks.create({
    :label => 'test-network',
    :cidr => '10.0.0.0/24'
  })
  @network = network
  ENV['network'] = network.id
end