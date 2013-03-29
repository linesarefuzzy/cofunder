require 'project_module'

class ProjectEvent < ActiveRecord::Base
  include ProjectModule
  
  self.table_name = 'ProjectEvents'
  self.primary_key = 'ID'
  belongs_to :Member, :foreign_key => 'MemberID'
  attr_accessible :Completed, :Date, :Details, :Finalized, :ProjectID, :ProjectTable, :Summary, :Type

	def project
	  return get_project(self)
	end
	
	def date
	  return self.Date.to_date # times are not used - all are set to midnight
	end
	
	def completed_or_not
	  self.Completed ? 'completed' : 'not_completed'
	end
end
