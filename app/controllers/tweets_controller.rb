class TweetsController < ApplicationController

  def index
    #
  end

  def retrive_tweets
    if params[:geo_cordinates].length == 0 or params[:radius] == ""
       response = {error: 'Missing cordinates or radius'}
       _status   = 400
    else
       response = Tweet.retrive_tweets(params)
       _status   = 200
    end

    render :json => response, :status => _status
  end
end