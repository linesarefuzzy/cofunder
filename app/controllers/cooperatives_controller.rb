class CooperativesController < ApplicationController
  # GET /cooperatives
  # GET /cooperatives.json
  def index
    @cooperatives = Cooperative.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @cooperatives }
    end
  end

  # GET /cooperatives/1
  # GET /cooperatives/1.json
  def show
    @cooperative = Cooperative.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @cooperative }
    end
  end

  # GET /cooperatives/new
  # GET /cooperatives/new.json
  def new
    @cooperative = Cooperative.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @cooperative }
    end
  end

  # GET /cooperatives/1/edit
  def edit
    @cooperative = Cooperative.find(params[:id])
  end

  # POST /cooperatives
  # POST /cooperatives.json
  def create
    @cooperative = Cooperative.new(params[:cooperative])

    respond_to do |format|
      if @cooperative.save
        format.html { redirect_to @cooperative, :notice => 'Cooperative was successfully created.' }
        format.json { render :json => @cooperative, :status => :created, :location => @cooperative }
      else
        format.html { render :action => "new" }
        format.json { render :json => @cooperative.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cooperatives/1
  # PUT /cooperatives/1.json
  def update
    @cooperative = Cooperative.find(params[:id])

    respond_to do |format|
      if @cooperative.update_attributes(params[:cooperative])
        format.html { redirect_to @cooperative, :notice => 'Cooperative was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @cooperative.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cooperatives/1
  # DELETE /cooperatives/1.json
  def destroy
    @cooperative = Cooperative.find(params[:id])
    @cooperative.destroy

    respond_to do |format|
      format.html { redirect_to cooperatives_url }
      format.json { head :no_content }
    end
  end
end
