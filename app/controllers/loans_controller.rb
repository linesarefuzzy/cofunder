class LoansController < ApplicationController
  # GET /loans
  # GET /loans.json
  def index
    params[:status] = 'active' if params[:status].blank? # show active loans by default
    @loans = Loan.filter_by_params(params).
                  includes(:cooperative, division: :super_division).
                  paginate(:page => params[:pg], :per_page => 20).
                  order('SigningDate DESC')
    @countries = Country.order(:Name).pluck(:Name)
    @language = 'EN' # to be replaced by session variable

    # Set last loan list URL for 'Back to Loan List' link
    session[:loans_path] = request.fullpath

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @loans }
    end
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
    @loan = Loan.status('all').find(params[:id])
    @pictures = @loan.featured_pictures(5) # for slideshow
    @other_loans = @loan.cooperative.loans.status('all').order("SigningDate DESC") if @loan.cooperative
    @repayments = @loan.repayments.order('DateDue')
    @language = 'EN' # to be replaced by session variable

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @loan }
    end
  end

  # GET /loans/1/gallery
  def gallery
    @loan = Loan.status('all').find(params[:id])
    @language = 'EN' # to be replaced by session variable
    @coop_media = @loan.coop_media(100, true).in_groups_of(4, false)
    @loan_media = (@loan.loan_media(100, true) + @loan.log_media(100, true)).in_groups_of(4, false)

    respond_to do |format|
      format.html
    end
  end

end
