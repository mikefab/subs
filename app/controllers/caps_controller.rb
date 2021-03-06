class CapsController < ApplicationController
  # GET /caps
  # GET /caps.xml


  def index
#    @caps = Cap.all
 
    @choice= params[:language]
    lang=params[:language] || "Spa"
    
    if params[:search] then
    @caps = Cap.search(params[:search], params[:page],lang)
    returned_results = @caps.size || 0

    grab_ip_info(params[:search],returned_results,params[:page],lang)
    (@verbs,@hash_id,@english) = Verb.return_verbs(@caps)

  end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @caps }
    end
  end
  
    def results
    
      if params[:movie]  then
        @caps=Cap.return_movie(params[:movie],params[:page])
   
        grab_ip_info(params[:movie],0,0,"")
      else
        @choice= params[:language]
        lang=params[:language] || "Spa"

      if ENV['RAILS_ENV']=="production" then
        if Rails.cache.exist?("#{params[:search]}-#{params[:page]}") then
           @caps = Rails.cache.read("#{params[:search]}-#{params[:page]}")
        else
          @caps = Cap.search(params[:search], params[:page],lang) 
          Rails.cache.fetch("#{params[:search]}-#{params[:page]}", :expires_in => 2.minutes){@caps}
        end
      else
          @caps = Cap.search(params[:search], params[:page],lang) 
      end
     returned_results = @caps.size || 0
     grab_ip_info(params[:search],returned_results,params[:page],lang)
    end
 
      (@verbs,@hash_id,@english) = Verb.return_verbs(@caps)



    end

    def soft()
      
    end

    def cap()
      ip = request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
      if params[:direction]=="back" then
        @cap = Cap.find(:last,:conditions=>["url=? and num < ?", params[:url], params[:num]], :order=>'num' )
      else
        @cap = Cap.find(:first,:conditions=>["url=? and num > ?", params[:url], params[:num]], :order=>'num' )
      end
        @cap = Cap.find(:first,:conditions=>["url=? and num = ?", params[:url], params[:num]] ) if !@cap
        @cap? returned_results=1 : returned_results=0

        grab_ip_info("#{params[:num]}-#{params[:url]}",returned_results,0,"")
      caps=Array.new()
      caps<<@cap
      (@verbs,@hash_id,@english) = Verb.return_verbs(caps)
      @cap
    end

  # GET /caps/1
  # GET /caps/1.xml
  def show
    @cap = Cap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cap }
    end
  end

  # GET /caps/new
  # GET /caps/new.xml
  def new
    @cap = Cap.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cap }
    end
  end

  # GET /caps/1/edit
  def edit
    @cap = Cap.find(params[:id])
  end

  # POST /caps
  # POST /caps.xml
  def create
    @cap = Cap.new(params[:cap])

    respond_to do |format|
      if @cap.save
        format.html { redirect_to(@cap, :notice => 'Cap was successfully created.') }
        format.xml  { render :xml => @cap, :status => :created, :location => @cap }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cap.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /caps/1
  # PUT /caps/1.xml
  def update
    @cap = Cap.find(params[:id])

    respond_to do |format|
      if @cap.update_attributes(params[:cap])
        format.html { redirect_to(@cap, :notice => 'Cap was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cap.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /caps/1
  # DELETE /caps/1.xml
  def destroy
    @cap = Cap.find(params[:id])
    @cap.destroy

    respond_to do |format|
      format.html { redirect_to(caps_url) }
      format.xml  { head :ok }
    end
  end


   def hide_all
     Rails.cache.clear()
     @cap = Cap.find(params[:id])
     @caps = Cap.find(:all, :conditions => ["url=?", @cap.url])
     @caps.each do |c|
       c.hide=1
       c.save
     end

  #render :text=>string
  #   Cap.destroy_all(:url => @cap.url)
     respond_to do |format|
       format.html { redirect_to(caps_url) }
       format.xml  { head :ok }
     end
    end


  def hide
    Rails.cache.clear()
    @cap = Cap.find(params[:id])
    @cap.hide=1
    @cap.save

 #render :text=>string
 #   Cap.destroy_all(:url => @cap.url)
    respond_to do |format|
      format.html { redirect_to(caps_url) }
      format.xml  { head :ok }
    end
   end
end
