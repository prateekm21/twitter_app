class Tweet
  include Mongoid::Document

  field :username,    type: String
  field :tweet,       type: String
  field :geo_loc,     type: Array
  field :tweet_date,  type: DateTime
  field :hash_tags,   type: Array

  index( { geo_loc: '2d', hash_tags: 1 }, { min: -180, max: 180 } )

  def self.retrive_tweets

  end

end