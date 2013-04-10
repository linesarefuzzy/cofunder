module ProjectModule
  def get_project(obj)
  	if obj.ProjectTable.downcase == 'loans'
		  return Loan.find(obj.ProjectID)
  	elsif obj.ProjectTable.downcase == 'basicprojects'
		  return BasicProject.find(obj.ProjectID)
    end
  end
end