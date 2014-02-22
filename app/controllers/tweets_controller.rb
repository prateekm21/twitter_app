class TweetsController < ApplicationController

  def index
    #
  end

  def retrieve_tweets
    if params[:geo_location].blank? or params[:radius].blank?
       response  = {error: 'Missing cordinates or radius'}
       _status   = 400
    else
       response = Tweet.retrieve_tweets(params)
       _status   = 200
    end

    render :json => response, :status => _status
  end
end