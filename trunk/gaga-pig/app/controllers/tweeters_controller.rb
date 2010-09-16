class TweetersController < ApplicationController
  def index
    @tweeters = Tweeters.find(:first)

  end

end
