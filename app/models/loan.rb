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
  
  def short_description(language_code)
    self.translation('ShortDescription', language_code)
  end
  def description(language_code)
    self.translation('Description', language_code)
  end
  
  def log_media(limit, images_only=false)
    media = []
    begin
      self.logs("Date").each do |log|
        media += get_media('ProjectLogs', log.id, limit - media.count, images_only)
        return media unless limit > media.count
      end
    rescue Mysql2::Error # some logs have invalid dates
    end
    return media
  end
  
  def featured_pictures(limit=1)
    pics = []
    coop_pics = get_media('Cooperatives', self.cooperative.id, limit, images_only=true)
    # use first coop picture first
    pics << coop_pics.shift if coop_pics.count > 0
    return pics unless limit > pics.count
    # then loan pics
    pics += get_media('Loans', self.id, limit - pics.count, images_only=true)
    return pics unless limit > pics.count
    # then log pics
    pics += self.log_media(limit - pics.count, images_only=true)
    return pics unless limit > pics.count
    # then remaining coop pics
    pics += coop_pics[0, limit - pics.count]
    return pics
  end
  
  def thumb_path
    if !self.featured_pictures.empty?
      self.featured_pictures.first.paths[:thumb]
    else "/assets/ww-avatar-watermark.png" end
  end
  
  def all_media
    {
      coop_media: get_media('Cooperatives', self.cooperative.id, 100),
      loan_media: get_media('Loans', self.id, 100),
      log_media: self.log_media(100)
    }
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
