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
    user_data.klout = information_about_user_klout(user_data.screen_name)
    user_data.twittercounter = information_about_user_twittercounter(user_data.screen_name)

    ret_hash = user_data.marshal_dump()
    ret_hash['tweeter_id'] = user_data.id
    ret_hash
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

      stats = {}

      stats[:followers] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[1]/td[1]/div").to_s.gsub(/<\/?[^>]*>/, "")
      stats[:followers_yesterday] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[1]/div/div[1]/span").to_s.gsub(/<\/?[^>]*>/, "")
      stats[:followers_average] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[1]/div/div[2]/span").to_s.gsub(/<\/?[^>]*>/, "")

      stats[:following] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[1]/td[2]/div").to_s.gsub(/<\/?[^>]*>/, "")
      stats[:following_yesterday] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[2]/div/div[1]/span").to_s.gsub(/<\/?[^>]*>/, "")
      stats[:following_average] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[2]/div/div[2]/span").to_s.gsub(/<\/?[^>]*>/, "")

      stats[:tweets] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[1]/td[3]/div").to_s.gsub(/<\/?[^>]*>/, "")
      stats[:tweets_yesterday] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[3]/div/div[1]/span").to_s.gsub(/<\/?[^>]*>/, "")
      stats[:tweets_average] = count_agente.page.search("/html/body/div[3]/div[2]/div[3]/table/tr[2]/td[3]/div/div[2]/span").to_s.gsub(/<\/?[^>]*>/, "")

      stats

    end

    def information_about_user_klout(search_name)
      search_url = "http://klout.com/" + search_name


      klout_agente = Mechanize.new
      klout_agente.get(search_url)

      klout = {}
      klout[:info] = klout_agente.page.search(".primary a").to_s.gsub(/<\/?[^>]*>/, "").gsub(/klout score/,"")

      klout[:influencedby] = Array.new
      klout[:influencerof] = Array.new
      5.times do |i|

       klout_influencedby = klout_agente.page.search("/html/body/div[2]/div/div[6]/div[4]/div[2]/div/ul/li[#{i+1}]/a/div[2]").to_s.gsub(/<\/?[^>]*>/, "")
       if klout_influencedby.empty?
          klout_influencedby = klout_agente.page.search("/html/body/div[2]/div/div[5]/div[4]/div[2]/div/ul/li[#{i+1}]/a/div[2]").to_s.gsub(/<\/?[^>]*>/, "")
          if not klout_influencedby.empty?
            klout[:influencedby] << klout_influencedby
          end
       else
          klout[:influencedby] << klout_influencedby
       end

       klout_influencerof = klout_agente.page.search("/html/body/div[2]/div/div[6]/div[5]/div[2]/div/ul/li[#{i+1}]/a/div[2]").to_s.gsub(/<\/?[^>]*>/, "")
       if klout_influencerof.empty?
          klout_influencerof = klout_agente.page.search("/html/body/div[2]/div/div[5]/div[5]/div[2]/div/ul/li[#{i+1}]/a/div[2]").to_s.gsub(/<\/?[^>]*>/, "")
          if not klout_influencerof.empty?
            klout[:influencerof] << klout_influencerof
          end
       else
          klout[:influencerof] << klout_influencerof
       end

      end

      klout
    end


end
