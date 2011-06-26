class SoftsController < ApplicationController
  # GET /softs
  # GET /softs.xml
  def index
    @softs = Soft.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @softs }
    end
  end

  # GET /softs/1
  # GET /softs/1.xml
  def show
    @soft = Soft.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @soft }
    end
  end

  # GET /softs/new
  # GET /softs/new.xml
  def new
    @soft = Soft.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @soft }
    end
  end

  # GET /softs/1/edit
  def edit
    @soft = Soft.find(params[:id])
  end

  # POST /softs
  # POST /softs.xml
  def create
    ip = request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
    
    @soft = Soft.new(:text=>params[:soft_eng],:cap_id=>params[:soft_id],:lang=>"eng",:user_id=>ip)
    respond_to do |format|
      if @soft.save
  @notice = 'Edit was successfully created. Please allow 24 hours for it to be reviewed.'
        format.html { redirect_to results_path() }
        format.js {}
      else
        @notice = 'Edit was not created.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @soft.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /softs/1
  # PUT /softs/1.xml
  def update
    @soft = Soft.find(params[:id])

    respond_to do |format|
      if @soft.update_attributes(params[:soft])
        format.html { redirect_to(@soft, :notice => 'Soft was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @soft.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /softs/1
  # DELETE /softs/1.xml
  def destroy
    @soft = Soft.find(params[:id])
    @soft.destroy

    respond_to do |format|
      format.html { redirect_to(softs_url) }
      format.xml  { head :ok }
    end
  end
end