class LoansController < ApplicationController
  # GET /loans
  # GET /loans.json
  def index
    # filter loan list
    nivel = case params[:show]
      when 'completed' then 'Prestamo Completo'
      when 'all' then ['Prestamo Activo','Prestamo Completo']
      else 'Prestamo Activo' # show active loans by default
    end
    country = (params[:country] == 'all' ? nil : params[:country])
    
    if country
      @loans = Loan.joins(:Division).where(:Nivel => nivel, 'Divisions.Country' => country).paginate(:page => params[:page], :per_page => 20).order('SigningDate DESC')
    else
      @loans = Loan.where(:Nivel => nivel).paginate(:page => params[:page], :per_page => 20).order('SigningDate DESC')
    end
    
    @countries = Country.order(:Name).pluck(:Name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @loans }
    end
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
    @loan = Loan.find(params[:id])
    @pictures = @loan.picture_paths(5) # for slideshow

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @loan }
    end
  end

  # def lend_form
  #   @loan = Loan.find(params[:id])
  # end

  # GET /loans/new
  # GET /loans/new.json
  # def new
  #   @loan = Loan.new
  # 
  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render :json => @loan }
  #   end
  # end

  # GET /loans/1/edit
  # def edit
  #   @loan = Loan.find(params[:id])
  # end

  # POST /loans
  # POST /loans.json
  # def create
  #   @loan = Loan.new(params[:loan])
  # 
  #   respond_to do |format|
  #     if @loan.save
  #       format.html { redirect_to @loan, :notice => 'Loan was successfully created.' }
  #       format.json { render :json => @loan, :status => :created, :location => @loan }
  #     else
  #       format.html { render :action => "new" }
  #       format.json { render :json => @loan.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # PUT /loans/1
  # PUT /loans/1.json
  # def update
  #   @loan = Loan.find(params[:id])
  # 
  #   respond_to do |format|
  #     if @loan.update_attributes(params[:loan])
  #       format.html { redirect_to @loan, :notice => 'Loan was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render :action => "edit" }
  #       format.json { render :json => @loan.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /loans/1
  # DELETE /loans/1.json
  # def destroy
  #   @loan = Loan.find(params[:id])
  #   @loan.destroy
  # 
  #   respond_to do |format|
  #     format.html { redirect_to loans_url }
  #     format.json { head :no_content }
  #   end
  # end
end
