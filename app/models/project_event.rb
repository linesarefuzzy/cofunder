class ProjectEvent < ActiveRecord::Base
  include Legacy, ProjectModule, TranslationModule
  
  belongs_to :member, :foreign_key => 'MemberID'
  has_many :project_logs, :foreign_key => 'PasoID'
  alias_attribute :logs, :project_logs
  attr_accessible :Completed, :Date, :Details, :Finalized, :ProjectID, :ProjectTable, :Summary, :Type

  def project; get_project(self); end
  def date; self.Date.to_date; end # times are not used - all are set to midnight
  
  def completed_or_not
    self.completed ? 'completed' : 'not_completed'
  end
  
  def status
    self.completed ? 'Completed' : self.project_logs.order("Date").last.try(:progress)
  end
  
  def summary(language_code="EN")
    self.translation('Summary', language_code) || self.Summary
  end
  def details(language_code="EN")
    self.translation('Details', language_code) || self.Details
  end

  def display_date
    self.completed || self.date
  end
end
