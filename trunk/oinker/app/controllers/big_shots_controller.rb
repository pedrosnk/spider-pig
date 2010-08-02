class BigShotsController < ApplicationController
  # GET /big_shots
  # GET /big_shots.xml
  def index
    @big_shots = BigShot.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @big_shots }
    end
  end

  # GET /big_shots/1
  # GET /big_shots/1.xml
  def show
    @big_shot = BigShot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @big_shot }
    end
  end

  # GET /big_shots/new
  # GET /big_shots/new.xml
  def new
    @big_shot = BigShot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @big_shot }
    end
  end

  # GET /big_shots/1/edit
  def edit
    @big_shot = BigShot.find(params[:id])
  end

  # POST /big_shots
  # POST /big_shots.xml
  def create
    @big_shot = BigShot.new(params[:big_shot])

    respond_to do |format|
      if @big_shot.save
        format.html { redirect_to(@big_shot, :notice => 'BigShot was successfully created.') }
        format.xml  { render :xml => @big_shot, :status => :created, :location => @big_shot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @big_shot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /big_shots/1
  # PUT /big_shots/1.xml
  def update
    @big_shot = BigShot.find(params[:id])

    respond_to do |format|
      if @big_shot.update_attributes(params[:big_shot])
        format.html { redirect_to(@big_shot, :notice => 'BigShot was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @big_shot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /big_shots/1
  # DELETE /big_shots/1.xml
  def destroy
    @big_shot = BigShot.find(params[:id])
    @big_shot.destroy

    respond_to do |format|
      format.html { redirect_to(big_shots_url) }
      format.xml  { head :ok }
    end
  end

  def message
  end

  def send
  end
end
