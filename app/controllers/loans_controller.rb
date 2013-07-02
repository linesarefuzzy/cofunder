class LoansController < ApplicationController
  # GET /loans
  # GET /loans.json
  def index
    params[:status] = 'active' if params[:status].blank? # show active loans by default
    @loans = Loan.filter_by_params(params).paginate(:page => params[:pg], :per_page => 20).order('SigningDate DESC')

    @countries = Country.order(:Name).pluck(:Name)
    
    if params[:embedded] 
      _layout = 'embedded'
      @embedded = true
    else _layout = 'application' end

    respond_to do |format|
      format.html { render layout: _layout } # index.html.erb
      format.json { render :json => @loans }
    end
  end
  
  # GET /loans/1
  # GET /loans/1.json
  def show
    @loan = Loan.find(params[:id])
    @pictures = @loan.picture_paths(5) # for slideshow
    @other_loans = @loan.cooperative.loans.status('all').order("SigningDate DESC")
    @repayments = @loan.repayments.order('DateDue')

    if params[:embedded] 
      _layout = 'embedded'
      @embedded = true
    else _layout = 'application' end

    respond_to do |format|
      format.html { render layout: _layout } # show.html.erb
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
