class ProjectLog < ActiveRecord::Base
  include Legacy, ProjectModule, TranslationModule

  remove_method :progress, :progress_metric

  belongs_to :member, :foreign_key => 'MemberID'
  belongs_to :paso, :foreign_key => 'PasoID'
  belongs_to :progress_metric, :foreign_key => 'ProgressMetric'
  attr_accessible :AdditionalNotes, :Date, :ProjectID, :ProjectTable
  
  def project; get_project(self); end
  def date; self.Date.to_date; end # times are not used - all are set to midnight
  def explanation(language_code='EN')
    self.translation('Explanation', language_code)
  end
  def detailed_explanation(language_code='EN')
    self.translation('DetailedExplanation', language_code)
  end
  def progress(language_code='EN', continuous=false)
    language = (language_code == 'ES' ? 'Spanish' : 'English')
    field_name = (continuous ? 'Continuous' : 'WithEvents')
    self.progress_metric.send(language + 'Display' + field_name).capitalize # e.g. EnglishDisplayWithEvents
  end
  def progress_continuous(language_code='EN')
    self.progress(language_code, true)
  end
end
