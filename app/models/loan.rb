class Loan < ActiveRecord::Base
  include Legacy, TranslationModule, MediaModule

  belongs_to :cooperative, :foreign_key => 'CooperativeID'
  belongs_to :division, :foreign_key => 'SourceDivision'
  has_many :repayments, :foreign_key => 'LoanID'
  attr_accessible :Amount, :Nivel, :Rate, :SigningDate

  scope :country, ->(country) { 
    joins(:division).where('Divisions.Country' => country) unless country == 'all' 
  }
  scope :status, ->(status) {
    where(:Nivel => case status
      when 'active' then 'Prestamo Activo'
      when 'completed' then 'Prestamo Completo'
      when 'all' then ['Prestamo Activo','Prestamo Completo']
    end)
  }

  def self.filter_by_params(params)
    scoped = self.scoped
    scoped = scoped.country(params[:country]) if params[:country]
    scoped = scoped.status(params[:status]) if params[:status]
    scoped
  end
  
  def name
    if self.cooperative then "Project with " + self.cooperative.Name 
    else "Project " + self.ID.to_s end
  end
  
  def country; self.division.country; end
  
  def location
    if self.cooperative.try(:city).present?
      self.cooperative.city + ', ' + self.country
    else self.country end
  end
  
  def signing_date_pretty
    self.signing_date.strftime("%b %e, %Y") if self.signing_date
  end
  
  def status
    case self.nivel
      when 'Prestamo Activo' then 'Active'
      when 'Prestamo Completo' then 'Completed'
    end
  end
  
  def get_short_description(language_code="EN")
    get_translation('Loans', 'ShortDescription', self.ID, language_code)
  end

  def get_description(language_code='EN')
    get_translation('Loans', 'Description', self.ID, language_code)
  end
  
  def picture_paths(limit=1)
    # get first coop picture first
    coop_pics = get_picture_paths('Cooperatives', self.cooperative.ID, limit)
    pics = (coop_pics.count > 0 ? [coop_pics.first] : [])
    return pics unless limit > pics.count
    # then loan pics
    pics += get_picture_paths('Loans', self.ID, limit - pics.count)
    return pics unless limit > pics.count
    # then log pics
    begin
      self.logs("Date").each do |log|
        pics += get_picture_paths('ProjectLogs', log.ID, limit - pics.count)
        return pics unless limit > pics.count
      end
    rescue Mysql2::Error; end # some logs have invalid dates
    # then remaining coop pics
    if limit > pics.count
      pics += coop_pics[1, limit - pics.count] || []
    end
    return pics
  end
  
  def main_picture
    self.picture_paths.try(:first)
  end
    
  def amount_formatted
    currency_format(self.amount, self.country)
  end
  
  def project_events(order_by="Completed IS NULL, Completed, Date")
    ProjectEvent.where("lower(ProjectTable) = 'loans' and ProjectID = ?", self.ID).order(order_by)
  end

  def logs(order_by="Date DESC")
    ProjectLog.where("lower(ProjectTable) = 'loans' and ProjectID = ?", self.ID).order(order_by)
  end
end
