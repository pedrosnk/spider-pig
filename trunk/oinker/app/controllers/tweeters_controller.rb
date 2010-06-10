class TweetersController < ApplicationController
  require 'grackle'
  # GET /tweeters
  # GET /tweeters.xml
  def index
    @tweeters = Tweeter.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tweeters }
    end
  end

  # GET /tweeters/1
  # GET /tweeters/1.xml
  def show
    @tweeter = Tweeter.find(params[:id])
      
    client = Grackle::Client.new
    @tweets = []
    t_tweets = client.statuses.user_timeline.json?(:screen_name => @tweeter.screen_name)
    t_tweets.each do |t_tweet|
      tweet = Tweet.new
      tweet.tweeter = @tweeter
      tweet.created_at = t_tweet.created_at
      tweet.twitter_id = t_tweet.id
      tweet.text = t_tweet.text
      tweet.source = t_tweet.source 
      tweet.in_reply_to_status_id = t_tweet.in_reply_to_status_id 
      tweet.in_reply_to_screen_name = t_tweet.in_reply_to_screen_name 
      tweet = Tweet.find_by_twitter_id(tweet.twitter_id) unless tweet.save
      @tweets << tweet
    end
    
    t_friends = client.friends.ids.json?(:screen_name => @tweeter.screen_name)
    @friends = []
    t_friends[0..5].each do |t_id|
      friend = create_or_update_tweeter(client.users.show?(:id => t_id))
      friend.save
      @friends = friend
    end
    
    t_followers = client.followers.ids.json?(:screen_name => @tweeter.screen_name)
    @followers = []
    t_followers[0..5].each do |t_id|
      follower = create_or_update_tweeter(client.users.show?(:id => t_id))
      follower.save
      @followers = follower
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tweeter }
    end
  end

  # GET /tweeters/new
  # GET /tweeters/new.xml
  def new
    @tweeter = Tweeter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tweeter }
    end
  end

  # GET /tweeters/1/edit
  def edit
    @tweeter = Tweeter.find(params[:id])
  end

  # POST /tweeters
  # POST /tweeters.xml
  def create
    client = Grackle::Client.new
    tmp = client.users.show?(:screen_name => params[:tweeter][:screen_name])
    @tweeter = create_or_update_tweeter tmp

    if @tweeter.save
      redirect_to(@tweeter, :notice => 'Tweeter was successfully inserted.')
    else
      render :action => 'new'
    end
  end

  # PUT /tweeters/1
  # PUT /tweeters/1.xml
  def update
    @tweeter = Tweeter.find(params[:id])

    respond_to do |format|
      if @tweeter.update_attributes(params[:tweeter])
        format.html { redirect_to(@tweeter, :notice => 'Tweeter was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tweeter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tweeters/1
  # DELETE /tweeters/1.xml
  def destroy
    @tweeter = Tweeter.find(params[:id])
    @tweeter.destroy

    respond_to do |format|
      format.html { redirect_to(tweeters_url) }
      format.xml  { head :ok }
    end
  end
  
  
  private
  def create_or_update_tweeter tmp
    tweeter = Tweeter.find_by_screen_name(tmp.screen_name)
    tweeter = Tweeter.new if tweeter.nil?
    tweeter.created_at = tmp.created_at
    tweeter.friends_count = tmp.friends_count
    tweeter.profile_image_url = tmp.profile_image_url
    tweeter.followers_count = tmp.followers_count
    tweeter.screen_name = tmp.screen_name
    tweeter.location = tmp.location
    tweeter.geo_enabled = tmp.geo_enabled
    tweeter.time_zone = tmp.time_zone
    tweeter.protected = tmp.protected
    tweeter.description = tmp.description
    tweeter.profile_background_image_url = tmp.profile_background_image_url
    tweeter.url = tmp.url
    tweeter.statuses_count = tmp.statuses_count
    tweeter
  end
end
