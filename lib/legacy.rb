# Methods and declarations for dealing with legacy database
# Include in models referring to tables created outside of rails. Tables generated by rails follow rails conventions. 
module Legacy
  extend ActiveSupport::Concern

  included do
    # tell rails to look for table name in CamelCase instead of default under_score
    self.table_name = self.table_name.camelize
    self.primary_key = 'ID'
    
    # make CamelCase column names accessible as under_score
    column_names.each do |col|
      alias_attribute col.underscore, col
    end
  end
end
