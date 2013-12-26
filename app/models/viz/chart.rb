class Viz::Chart < ActiveRecord::Base

  #GEMS USED
  self.table_name = :viz_charts
  
  #ACCESSORS
  attr_accessible :genre, :img, :mapping, :name
  
  #ASSOCIATIONS  
  #VALIDATIONS
  #CALLBACKS
  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS  
  
  def mapper
    if self.genre == "1D"
      Viz::Chart.1d_mapper
    end
  end
  
  def self.1d_mapper
    
  end
  
  #UPSERT
  #JOBS
  #PRIVATE
  private  
  
end
