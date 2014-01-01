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
      Viz::Chart.mapper_1d_or_2d(genre, raw_data, headings, map_json)
    elsif self.genre == CHART_WT
      Viz::Chart.mapper_unweighted_tree(viz)
    elsif self.genre == CHART_T
      Viz::Chart.mapper_weighted_tree(viz)
    elsif self.genre == CHART_RELATION
      Viz::Chart.mapper_relations(viz)
    elsif self.genre == CHART_2D
      Viz::Chart.mapper_1d_or_2d(genre, raw_data, headings, map_json)
    elsif self.genre == CHART_W2D
      Viz::Chart.mapper_weighted_2d(raw_data, headings, map_json)
    elsif self.genre == CHART_GS2D
      Viz::Chart.mapper_groupedstacked_2d(raw_data, headings, map_json)
    end
  end
  
  def self.mapper_1d_or_2d(genre, raw_data, headings, map_json)    
    transformed_data = [{"key" => "Chart","values" => []}] #json_data
    h = {}
    out = []
    raw_data.each do |row|
      if genre == CHART_1D
        label = row[headings.index(map_json["Dimension"])]
        value = row[headings.index(map_json["Size"])]
      elsif genre == CHART_2D
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
  
  def self.incomplete(raw_data, headings, map_json)
    transformed_data = [{"key" => "Chart","values" => []}] #json_data
    h = {}
    out = []
    raw_data.each do |row|
      label = row[headings.index(map_json["X"])]
      value = row[headings.index(map_json["Y"])]
      group  = row[headings.index(map_json["Group"])]
      stack  = row[headings.index(map_json["Stack"])]
      unique_label = label
      unique_label = "#{unique_label}_" + group if group.present?
      unique_label = "#{unique_label}_" + stack if stack.present?
      if h[unique_label].present?
        h[unique_label] = {"x" => h[unique_label]["x"], "y" => h[unique_label]["y"].to_f + value.to_f, "group" => h[unique_label]["group"], "stack" => h[unique_label]["stack"]}
      else        
        h[unique_label] = {"x" => h[unique_label]["x"], "y" => h[unique_label]["y"].to_f + value.to_f, "group" => h[unique_label]["group"], "stack" => h[unique_label]["stack"]}
        #{"y" => value.to_f, "size" => size.to_f}
      end
    end
    if h != {}
      h.each do |key, val, size|
        out << [key, val, size]
      end
      transformed_data[0]["values"].push(out)
    end  
    transformed_data.to_json    
  end
  
  def self.mapper_weighted_2d(raw_data, headings, map_json)
    transformed_data = [{"key" => "Chart","values" => []}] #json_data
    h = {}
    out = []
    raw_data.each do |row|
      label = row[headings.index(map_json["X"])]
      value = row[headings.index(map_json["Y"])]
      size  = row[headings.index(map_json["Size"])]
      if h[label].present?
        h[label] = {"y" => h[label]["y"].to_f + value.to_f, "size" => h[label]["size"].to_f + size.to_f }
      else        
        h[label] = {"y" => value.to_f, "size" => size.to_f}
      end
    end
    if h != {}
      h.each do |key, val, size|
        out << [key, val, size]
      end
      transformed_data[0]["values"].push(out)
    end  
    transformed_data.to_json    
  end   
  
  #UPSERT
  #JOBS
  #PRIVATE
  private  
  
end
