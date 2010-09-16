class TweetController < ApplicationController

  def index
    @tweet = Tweet.find(:first, :conditions => { :screen_name => params[:tweet_url] })

    @tweet_followings = TweetFollowing.find(:conditions => { :screen_name => params[:tweet_url] })

  end

end
