Then(/^the container "(.*?)" should contain a file matching \/(.*?)\/$/) do |container, file_pattern|
  dir = @storage.directories.find {|d| d.key == container}
  file_regex = Regexp.new file_pattern
  file = dir.files.select {|f| f.key}
  file.should_not be_nil
end

Given(/^the container "(.*?)" does not exist$/) do |container|
  dir = @storage.directories.find {|d| d.key == container}
  unless dir.nil?
    dir.files.each do |f|
      f.destroy
    end
    dir.destroy
  end
end
