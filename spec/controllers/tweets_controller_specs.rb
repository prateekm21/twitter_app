require 'spec_helper'

describe TweetsController do
  before(:all) do
    @location = ["12.25542","13.545454"]
    @radius   = 10
  end  

  describe "GET index" do
    
    it "should return success response" do
      get :index
      response.should be_success
    end
  end

  describe "GET retrieve_tweets" do

    it "should return 422 status if params missing" do
      get :retrieve_tweets , :geo_location => [],  :radius => ""

      response.status.should eql(422)
      JSON.parse(response.body)['error'].should  eql('Missing cordinates or radius')
    end

    it "should return desired info with correct params" do
      Tweet.should_receive(:retrive_tweets).and_return({okay: true})
      get :retrieve_tweets , :geo_location => @location,  :radius => @radius

      response.status.should eql(200)
      JSON.parse(response.body)['okay'].should be_true
    end

    it "should return desired info with page in params" do
      Tweet.should_receive(:retrive_tweets).and_return({okay: true})
      get :retrieve_tweets , :geo_location => @location,  :radius => @radius,  :page => 1, :per_page => 1

      response.status.should eql(200)
      JSON.parse(response.body)['okay'].should be_true
    end

  end
end