#require 'rubygems'
#require 'mechanize'

class GagaController < ApplicationController

#  require 'mechanize'

  def search
    @search_name = params[:search_name]
    information_about_user_klout(@search_name)
    information_about_user_twittercounter(@search_name)


    save_tweet


    @search_name = "@" << @search_name

  end

  def index
    
  end

  def salvar_tweet
    
  end


  private

    def save_tweet

      tweet = Tweet.find(:first, :conditions => { :screen_name => @search_name })

      tweet = Tweet.new unless tweet


      tweet.screen_name = @search_name
      tweet.klout = Klout.new
      tweet.klout.classification = @klout_info

      tweet.twittercounter = Twittercounter.new

      tweet.twittercounter.followers = @counter_followers
      tweet.twittercounter.followers_yesterday = @counter_followers_yesterday
      tweet.twittercounter.followers_average = @counter_followers_average

      tweet.twittercounter.following = @counter_following
      tweet.twittercounter.following_yesterday = @counter_following_yesterday
      tweet.twittercounter.following_average = @counter_following_average

      tweet.twittercounter.tweets = @counter_tweets
      tweet.twittercounter.tweets_yesterday = @counter_tweets_yesterday
      tweet.twittercounter.tweets_average = @counter_tweets_average


      tweet.save


    end

    def information_about_user_klout(search_name)
      search_url = "http://klout.com/" + search_name


      klout_agente = Mechanize.new
      klout_agente.get(search_url)

      @klout_info = klout_agente.page.search(".primary a").to_s.gsub(/<\/?[^>]*>/, "").gsub(/klout score/,"")

      @klout_influencedby = Array.new
      @klout_influencerof = Array.new
      5.times do |i|

       klout_influencedby = klout_agente.page.search("/html/body/div[2]/div/div[6]/div[4]/div[2]/div/ul/li[#{i+1}]/a/div[2]").to_s.gsub(/<\/?[^>]*>/, "")
       if klout_influencedby.empty?
          klout_influencedby = klout_agente.page.search("/html/body/div[2]/div/div[5]/div[4]/div[2]/div/ul/li[#{i+1}]/a/div[2]").to_s.gsub(/<\/?[^>]*>/, "")
          if not klout_influencedby.empty?
            @klout_influencedby << klout_influencedby
          end
       else
          @klout_influencedby << klout_influencedby
       end

       klout_influencerof = klout_agente.page.search("/html/body/div[2]/div/div[6]/div[5]/div[2]/div/ul/li[#{i+1}]/a/div[2]").to_s.gsub(/<\/?[^>]*>/, "")
       if klout_influencerof.empty?
          klout_influencerof = klout_agente.page.search("/html/body/div[2]/div/div[5]/div[5]/div[2]/div/ul/li[#{i+1}]/a/div[2]").to_s.gsub(/<\/?[^>]*>/, "")
          if not klout_influencerof.empty?
            @klout_influencerof << klout_influencerof
          end
       else
          @klout_influencerof << klout_influencerof
       end
       
      end

    end


    def information_about_user_twittercounter(search_name)
      search_url = "http://twittercounter.com/" + search_name

      count_agente = Mechanize.new
      count_agente.get(search_url)

      @counter_followers = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[1]/td[1]/div").to_s.gsub(/<\/?[^>]*>/, "")
      @counter_followers_yesterday = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[1]/div/div[1]/span").to_s.gsub(/<\/?[^>]*>/, "")
      @counter_followers_average = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[1]/div/div[2]/span").to_s.gsub(/<\/?[^>]*>/, "")

      @counter_following = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[1]/td[2]/div").to_s.gsub(/<\/?[^>]*>/, "")
      @counter_following_yesterday = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[2]/div/div[1]/span").to_s.gsub(/<\/?[^>]*>/, "")
      @counter_following_average = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[2]/div/div[2]/span").to_s.gsub(/<\/?[^>]*>/, "")

      @counter_tweets = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[1]/td[3]/div").to_s.gsub(/<\/?[^>]*>/, "")
      @counter_tweets_yesterday = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[3]/div/div[1]/span").to_s.gsub(/<\/?[^>]*>/, "")
      @counter_tweets_average = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[3]/div/div[2]/span").to_s.gsub(/<\/?[^>]*>/, "")

    end


    

end
