class Data::FileColumn < ActiveRecord::Base
  
  #GEMS USED
  self.table_name = :data_file_columns
  has_paper_trail
  
  #ACCESSORS
  attr_accessible :data_file_id, :datatype, :name
  
  #ASSOCIATIONS
  belongs_to :data_file, :class_name => 'Data::File', :foreign_key => "data_file_id"
  
  
  

  
  #VALIDATIONS
  #CALLBACKS
  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS  
  #UPSERT
  #JOBS
  #PRIVATE
  private
  
end
