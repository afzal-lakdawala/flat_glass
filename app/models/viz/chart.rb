class Viz::Chart < ActiveRecord::Base

  #GEMS USED
  self.table_name = :viz_charts
  
  #ACCESSORS
  attr_accessible :genre, :img, :mapping, :name, :description
  
  #ASSOCIATIONS  
  #VALIDATIONS
  #CALLBACKS
  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS  
  
  def mapper(viz)
    raw_data = JSON.parse(viz.data_filz.content)
    headings = raw_data.shift
    headings = headings.collect{|h| h.split(":").first}
    map_json = JSON.parse(viz.map).invert
    if self.genre == "1D"
      Viz::Chart.mapper_1d(raw_data, headings, map_json)
    elsif self.genre == "Unweighted Tree"
      Viz::Chart.mapper_unweighted_tree(viz)
    elsif self.genre == "Weighted Tree"
      Viz::Chart.mapper_weighted_tree(viz)
    elsif self.genre == "Relationship Charts"
      Viz::Chart.mapper_relations(viz)
    elsif self.genre == "2D Charts"
      Viz::Chart.mapper_2d(viz)
    end
  end
  
  def self.mapper_1d(raw_data, headings, map_json)    
    transformed_data = [{"key" => "Chart","values" => []}] #json_data
    h = {}
    out = []
    raw_data.each do |row|
      label = row[headings.index(map_json["Dimension"])]
      value = row[headings.index(map_json["Size"])]
      h[label] = h[label].present? ? (h[label].to_f + value.to_f) : value.to_f
    end
    if h != {}
      h.each do |key, val|
        out << [key, val]
      end
      transformed_data[0]["values"].push(out)
    end  
    transformed_data.to_json
  end
  
  def self.mapper_weighted_tree
  end
  
  def self.mapper_unweighted_tree
  end
  
  def self.mapper_relations
  end
  
  def self.mapper_2d
  end   
  
  #UPSERT
  #JOBS
  #PRIVATE
  private  
  
end
