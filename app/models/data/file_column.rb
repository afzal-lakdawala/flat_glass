class Data::FilzColumn < ActiveRecord::Base
  
  #GEMS USED
  self.table_name = :data_filz_columns
  has_paper_trail
  
  #ACCESSORS
  attr_accessible :data_filz_id, :datatype, :name
  
  #ASSOCIATIONS
  belongs_to :data_filz, :class_name => 'Data::Filz', :foreign_key => "data_filz_id"
  
  
  

  
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
