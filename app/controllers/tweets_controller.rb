class TweetsController < ApplicationController

  def index

  end

  def retrive_tweets
    render :json => {okay: true}
  end
end