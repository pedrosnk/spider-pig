class TweetersController < ApplicationController
  def index
    @tweeters = Tweeters.find(:first, :conditions => { :screen_name => params[:tweet_url] })
  end

  def status
    @tweeters = Tweeters.find(:all, :conditions => { :screen_name => params[:tweet_url] })
    @tweet_status = Array.new
    @tweeters.each do |t|
      Statuses.find(:all ).each do |s|
        if (s.user == t._id)
          @tweet_status << s
        end
      end
    end
    #@tweet_status = Statuses.find(:first)
  end

end
