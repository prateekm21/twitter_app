class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps
  field :username,    type: String
  field :tweet,       type: String
  field :location,    type: Array
  field :tweet_date,  type: DateTime
  field :hash_tags,   type: Array
  index({location: Mongo::GEO2D, hash_tags: 1}, {min: -180, max: 180})

  def self.retrive_tweets params
    _location = params[:geo_location].map {|e| e.to_f}
    _radius   = params[:radius].to_f
    _hash_tag = params[:hash_tag]
    _pg_num   = params[:page]
    _per_page = params[:per_page]

    tweet_list = Tweet.within_circle( location: [ _location, _radius ] ).desc('tweet_date') rescue []
    tweet_list = self.filter_with_hash_tag(tweet_list, _hash_tag) unless tweet_list.blank? || _hash_tag.blank?

    #paginate if required
    if _pg_num.present? && _per_page.present? && tweet_list.present?
      response ||= {}
      response[:response] = tweet_list.paginate(:page => _pg_num, :per_page => _per_page)
      response[:total]    = tweet_list.count
    else
      response = {:response=> tweet_list, :total => tweet_list.count}
    end

    response
  end

  def self.filter_with_hash_tag(tweet_list, hash_tags)
    tweet_list.in(hash_tags: hash_tags)
  end

end