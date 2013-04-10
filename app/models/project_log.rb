require 'project_module'
require 'translation_module'

class ProjectLog < ActiveRecord::Base
  include ProjectModule, TranslationModule
  
  self.table_name = 'ProjectLogs'
  self.primary_key = 'ID'
  belongs_to :Member, :foreign_key => 'MemberID'
  belongs_to :Paso, :foreign_key => 'PasoID'
  attr_accessible :AdditionalNotes, :Date, :Progress, :ProjectID, :ProjectTable
  
  def project; get_project(self); end
  def date; self.Date.to_date; end # times are not used - all are set to midnight
	def explanation
	  get_translation('ProjectLogs', 'Explanation', self.ID, language_code='EN')
  end
	def detailed_explanation
	  get_translation('ProjectLogs', 'DetailedExplanation', self.ID, language_code='EN')
  end
end