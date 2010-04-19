require 'nokogiri'
require 'open-uri'

class ResourcesController < ApplicationController
  # GET /resources
  # GET /resources.xml
  def index
    @resources = Resource.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resources }
    end
  end

  # GET /resources/1
  # GET /resources/1.xml
  def show
    @resource = Resource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/new
  # GET /resources/new.xml
  def new
    @resource = Resource.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
  end

  # POST /resources
  # POST /resources.xml
  def create
    @resource = Resource.new(params[:resource])

    respond_to do |format|
      if @resource.save
        flash[:notice] = 'Resource was successfully created.'
        format.html { redirect_to(@resource) }
        format.xml  { render :xml => @resource, :status => :created, :location => @resource }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resources/1
  # PUT /resources/1.xml
  def update
    @resource = Resource.find(params[:id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        flash[:notice] = 'Resource was successfully updated.'
        format.html { redirect_to(@resource) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.xml
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to(resources_url) }
      format.xml  { head :ok }
    end
  end
  
  def capture
    items_array = items
    items_array.each do |url|
      doc = Nokogiri::HTML(open(url))
      attributes = {:url => url, :title => doc.xpath('//title').inner_text.strip, :content => cleanup_plain_text(doc.inner_text) }
      old = Resource.find(:first,:conditions => ['url = ?',url])
      if(old)
        old.update_attributes(attributes)
      else
        resource = Resource.new(attributes)
        resource.save
      end
    end
    redirect_to root_path
  end
  
  def search
   
  end
  
  def items
    return %w{ http://radicaos.com http://aonderaioseuvimparar.blogspot.com http://www.devir.com.br }
  end
  
  def cleanup_plain_text text
    text.gsub!('>', '> ')
    if text.index('<')
      text = HTML::FullSanitizer.new.sanitize(text)
    end
    remove_extra_whitespace(text)
  end
  
  def remove_extra_whitespace text
    text = text. gsub(/\s{2,}|\t|\n/,' ')
    text
  end
end
