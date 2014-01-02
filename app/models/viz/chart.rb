class Viz::Chart < ActiveRecord::Base

  #GEMS USED
  self.table_name = :viz_charts
  
  #CONSTANTS
  CHART_1D = "1D"
  CHART_2D = "2D"
  CHART_W2D = "Weighted 2D"
  CHART_GS2D = "Grouped Stacked 2D"
  CHART_WT = "Weighted Tree"
  CHART_T = "Tree"
  CHART_RELATION = "Relationship"
  CHART_MAP = "Map"
  MAP_MANDATORY = "M"
  MAP_OPTIONAL = "O"

  
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
    if self.genre == CHART_1D or self.genre == CHART_2D or self.genre == CHART_W2D or self.genre == CHART_GS2D
      Viz::Chart.mapper_1d_or_2d(genre, raw_data, headings, map_json)
    elsif self.genre == CHART_WT
      Viz::Chart.mapper_unweighted_tree(viz)
    elsif self.genre == CHART_T
      Viz::Chart.mapper_weighted_tree(viz)
    elsif self.genre == CHART_RELATION
      Viz::Chart.mapper_relations(viz)
    end
  end
  
  def self.mapper_1d_or_2d(genre, raw_data, headings, map_json)    
    transformed_data = [{"key" => "Chart","values" => []}] #json_data
    h = {}
    out = []
    raw_data.each do |row|
      if genre == CHART_1D
        label = row[headings.index(map_json["Dimension"])]
      elsif genre == CHART_2D or CHART_W2D or CHART_GS2D
        label = row[headings.index(map_json["X"])]        
      end
      group = map_json["Group"].present? ? row[headings.index(map_json["Group"])]     : "_"
      stack = map_json["Stack"].present? ? row[headings.index(map_json["Stack"])]     : "_"
      size  = map_json["Size"].present?  ? row[headings.index(map_json["Size"])].to_f : 0.0
      y     = map_json["Y"].present?     ? row[headings.index(map_json["Y"])].to_f    : 0.0
      unique_label = "#{label}#{group}#{stack}" #create a unique label of all dimensions which will act as KEY
      if h[unique_label].present?
        h[unique_label] = {"label" => label, 
                            "group" => group, 
                            "stack" => stack, 
                            "y" => h[unique_label]["y"].to_f + y.to_f, 
                            "size" => h[unique_label]["size"].to_f + size.to_f }
      else
        h[unique_label] = {"label" => label, "group" => group, "stack" => stack, "y" => y.to_f, "size" => size.to_f}
      end
    end
    if h != {}
      h.each do |unique_label, label, group, stack, size, y|
        out << [label, group, stack, size, y]
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
      
  #UPSERT
  #JOBS
  #PRIVATE
  private  
  
end
