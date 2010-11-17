class StatusInfluenceController < ApplicationController
  
  
  def index
      @status_influence = StatusInfluence.find(:all)
  end

  def auth
    omniauth = YAML::load( request.env["rack.auth"].to_yaml )
    session[:twitter_token] = omniauth['credentials']['token']
    session[:twitter_token_secret] = omniauth['credentials']['secret']
    redirect_to status_influence_new_msg_path
  end

  def new_msg
    @status_influence = StatusInfluence.new
    
    if params[:text]
      flash[:notice] = 'tentando salvar mensagem'
      consumer_data = YAML::load( File.open('config/twitter_app.yml') )
      client = Grackle::Client.new(:auth=>{
          :type=>:oauth,
          :consumer_key=> consumer_data['consumer_key'], :consumer_secret=>consumer_data['consumer_secret'],
          :token=> session[:twitter_token], :token_secret => session[:twitter_token_secret]
        })
      update = client.statuses.update.json! :status=>params[:text]
      render :text => update.class
    else
      flash[:notice] = 'escreva uma msg para o bilionariodf usar'
      redirect_to 'http://localhost:3000/auth/twitter' unless session[:twitter_token]
    end
  end

end
