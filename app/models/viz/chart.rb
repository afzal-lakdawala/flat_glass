class Viz::Chart < ActiveRecord::Base

  #GEMS USED
  self.table_name = :viz_charts
  
  #CONSTANTS
  CHART_1D = "1D"
  CHART_2D = "2D Charts"
  CHART_W2D = "Weighted 2D Charts"
  CHART_WT = "Weighted Tree"
  CHART_T = "Tree"
  CHART_RELATION = "Relationship Charts"
  CHART_MAP = "Map"
  
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
    if self.genre == CHART_1D
      Viz::Chart.mapper_1d_or_2d(raw_data, headings, map_json)
    elsif self.genre == CHART_WT
      Viz::Chart.mapper_unweighted_tree(viz)
    elsif self.genre == CHART_T
      Viz::Chart.mapper_weighted_tree(viz)
    elsif self.genre == CHART_RELATION
      Viz::Chart.mapper_relations(viz)
    elsif self.genre == CHART_2D
      Viz::Chart.mapper_1d_or_2d(raw_data, headings, map_json)
    elsif self.genre == CHART_W2D
      Viz::Chart.mapper_weighted_2d(raw_data, headings, map_json)
    end
  end
  
  def self.mapper_1d_or_2d(raw_data, headings, map_json)    
    transformed_data = [{"key" => "Chart","values" => []}] #json_data
    h = {}
    out = []
    raw_data.each do |row|
      if self.genre == "1D"
        label = row[headings.index(map_json["Dimension"])]
        value = row[headings.index(map_json["Size"])]
      elsif self.genre == "2D Charts"
        label = row[headings.index(map_json["X"])]
        value = row[headings.index(map_json["Y"])]
      end
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
  
  def self.mapper_weighted_2d(raw_data, headings, map_json)
    ### x, y, size
  end   
  
  #UPSERT
  #JOBS
  #PRIVATE
  private  
  
end
