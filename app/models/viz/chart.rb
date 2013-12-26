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
    transformed_data = [{"key" => "Chart","values" => []}] #json_data
    map_json = JSON.parse(viz.map).invert
    if self.genre == "1D"
      Viz::Chart.mapper_1d(raw_data, headings, transformed_data, map_json)
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
  
  def self.mapper_1d(raw_data, headings, transformed_data, map_json)    
    raw_data.each do |row|
      h = {}
      label = row[headings.index(map_json["Dimension"])]
      value = row[headings.index(map_json["Size"])]
      el = false
      transformed_data[0]["values"].each_with_index do |set, i|
        if set["label"] == label
          el = i
        end
      end
      unless el
        h["label"] = label
        h["value"] = value.to_i
        transformed_data[0]["values"].push(h);
      else
        hash = transformed_data[0]["values"][el]
        hash["value"] += value.to_i
        transformed_data[0]["values"][el] = hash
      end
      if h != {}
        transformed_data[0]["values"].push(h);
      end
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
