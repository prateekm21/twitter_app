require 'spec_helper'
require 'tweet_helper'

describe Tweet do

  let(:tweet_sample) { JSON.parse(File.read("#{Rails.root}/spec/fixtures/tweet_sample.json")) }

end