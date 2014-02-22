require 'spec_helper'
require 'tweet_helper'

describe Tweet do

  let(:tweet_sample) { JSON.parse(File.read("#{Rails.root}/spec/fixtures/tweet_sample.json")) }

  before(:all) do
     clean_db
  end

  context "create tweet" do
    it "should be able to create tweet" do
       sample = tweet_sample[0]
       resp   = Tweet.create!({})

       resp.id.to_s.should match(/[a-z0-9]/i)
       Tweet.count.should eql(1)
    end
  end

  describe "#retrive_tweets" do
    before(:each) do
      clean_db
      prep_db(tweet_sample)
    end

    it "should return all tweets within a circle" do
      params = {
        geo_location: [46.7495932, -92.1179977],
        radius:       '.5'
      }

      response = Tweet.retrive_tweets(params)
      response[:total].should eql(27)
    end

    it "should return zero tweets for outside a circle" do
      params = {
          geo_location: [56.7495932, -62.1179977],
          radius:       '.5'
      }

      resp = Tweet.retrive_tweets(params)
      resp[:total].should eql(0)
    end

    it "should return only tweets with desired hash tag within a circle" do
      params = {
          geo_location: [46.7495932, -92.1179977],
          radius:       '.5',
          hash_tag:     ["hello"]
      }

      resp = Tweet.retrive_tweets(params)
      resp[:total].should eql(3)
    end

    it "should return no tweets if hash tag in a circle does not exist" do
      params = {
          geo_location: [46.7495932, -92.1179977],
          radius:       '.5',
          hash_tag:     ["bogus"]
      }

      resp = Tweet.retrive_tweets(params)
      resp[:total].should eql(0)
    end

    it "should paginate and return tweets" do
      params = {
          geo_location: [46.7495932, -92.1179977],
          radius:       '.5',
          page:  1,
          per_page:     1
      }

      resp = Tweet.retrive_tweets(params)
      resp[:response].count.should eql(1)
    end
  end

end