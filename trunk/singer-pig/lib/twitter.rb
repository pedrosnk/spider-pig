# Author: Renato Fernandes de Queiroz

require 'grackle'
require 'mechanize'

class Twitter
  @@client  = Grackle::Client.new

  def initialize (hash)
    @hash = hash
  end

  def user
    user_data = @@client.users.show.json?(@hash)
    user_data.delete_field('status')
    # klout and twitter_counter data
    user_data
  end

  def timeline
    @@client.statuses.user_timeline.json?(@hash)
  end

  def friends
    @@client.friends.ids.json?(@hash)
  end


  private
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


end
