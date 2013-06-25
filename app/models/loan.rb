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
  
  def country; self.division.Country; end
  def location; self.cooperative.City + ', ' + self.country; end
  def signing_date_pretty; self.signing_date.strftime("%b %e, %Y"); end
  
  def status
    case self.nivel
      when 'Prestamo Activo' then 'Active'
      when 'Prestamo Completo' then 'Completed'
    end
  end
  
  def get_short_description(language_code="EN")
    return get_translation('Loans', 'ShortDescription', self.ID, language_code)
  end

  def get_description(language_code='EN')
    return get_translation('Loans', 'Description', self.ID, language_code)
  end
  
  def picture_paths(limit=1)
    return get_picture_paths('Loans', self.ID, limit) || get_picture_paths('Cooperatives', self.cooperative.ID, limit)
  end
  
  def main_picture
    return self.picture_paths.try(:first)
  end
    
  def amount_formatted
    return currency_format(self.amount, self.country)
  end
  
  def project_events(order_by="Completed IS NULL, Completed, Date")
    return ProjectEvent.where("lower(ProjectTable) = 'loans' and ProjectID = ?", self.ID).order(order_by)
  end
end
