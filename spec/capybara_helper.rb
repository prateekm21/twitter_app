require 'nokogiri'

Capybara.default_wait_time = 5

Capybara.configure do |config|
  config.match                  = :prefer_exact
  config.ignore_hidden_elements = false
end

FIXTURES_ROOT = "#{Rails.root}/spec/fixtures"

module DBHelper

  def populate_db 
    sample =  JSON.parse(File.read("#{FIXTURES_ROOT}/tweet_sample.json"))
    
    sample.each_index do |i|
     Tweet.create!(sample[i])
    end
  end  
end