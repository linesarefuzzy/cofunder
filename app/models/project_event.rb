class ProjectEvent < ActiveRecord::Base
  include Legacy, ProjectModule, TranslationModule
  
  belongs_to :Member, :foreign_key => 'MemberID'
  has_many :ProjectLogs, :foreign_key => 'PasoID'
  alias_attribute :logs, :ProjectLogs
  attr_accessible :Completed, :Date, :Details, :Finalized, :ProjectID, :ProjectTable, :Summary, :Type

  def project; get_project(self); end
  def date; self.Date.to_date; end # times are not used - all are set to midnight
  def completed_or_not
    self.Completed ? 'completed' : 'not_completed'
  end
  def summary(language_code="EN")
    get_translation('ProjectEvents', 'Summary', self.ID, language_code) || self.Summary
  end
  def details(language_code="EN")
    get_translation('ProjectEvents', 'Details', self.ID, language_code) || self.Details
  end
end
