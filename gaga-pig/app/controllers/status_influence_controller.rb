class StatusInfluenceController < ApplicationController
  def index
  end

  def new_msg
    @status_influence = StatusInfluence.new
  end

end
