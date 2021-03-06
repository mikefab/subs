class VerbsController < ApplicationController
  # GET /verbs
  # GET /verbs.xml
  def index

    @verbs = Verb.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @verbs }
    end
  end

  def tenses


    @tenses = Verb.return_tenses(params[:tense_mood])
    returned_results=@tenses.size || 0
    grab_ip_info(params[:tense_mood], returned_results,0,"")
  end

  def verbs

    if(params[:verb].size>0)
      @verbs = Verb.return_verb(params[:verb])
    else
      @verbs = Verb.return_mood_verbs(params[:verb_mood],params[:verb_tense])
    end

   end
    
    
  # GET /verbs/1
  # GET /verbs/1.xml
  def show
    @verb = Verb.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @verb }
    end
  end

  # GET /verbs/new
  # GET /verbs/new.xml
  def new
    @verb = Verb.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @verb }
    end
  end

  # GET /verbs/1/edit
  def edit
    @verb = Verb.find(params[:id])
  end

  # POST /verbs
  # POST /verbs.xml
  def create
    @verb = Verb.new(params[:verb])

    respond_to do |format|
      if @verb.save
        format.html { redirect_to(@verb, :notice => 'Verb was successfully created.') }
        format.xml  { render :xml => @verb, :status => :created, :location => @verb }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @verb.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /verbs/1
  # PUT /verbs/1.xml
  def update
    @verb = Verb.find(params[:id])

    respond_to do |format|
      if @verb.update_attributes(params[:verb])
        format.html { redirect_to(@verb, :notice => 'Verb was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @verb.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /verbs/1
  # DELETE /verbs/1.xml
  def destroy
    @verb = Verb.find(params[:id])
    @verb.destroy

    respond_to do |format|
      format.html { redirect_to(verbs_url) }
      format.xml  { head :ok }
    end
  end
end
