require 'spec_helper'

describe TweetsController do

  describe "retrive_tweets" do

    it "should return success response" do
      get :retrive_tweets
      response.should be_success
    end
  end
end
