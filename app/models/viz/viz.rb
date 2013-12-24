class Viz::Viz < ActiveRecord::Base

  #GEMS USED
  self.table_name = :viz_vizs
  extend FriendlyId
  friendly_id :title, use: [:slugged, :scoped], scope: :account
  has_paper_trail
  require 'json'
  require 'csv'

  #ACCESSORS
  attr_accessible :data_filz_id, :map, :mapped_output, :settings, :title, :viz_chart_id, :created_by, :updated_by, :account_id, :slug

  #ASSOCIATIONS
  belongs_to :data_filz, class_name: "Data::Filz", foreign_key: "data_filz_id"
  belongs_to :viz_chart, class_name: "Viz::Chart", foreign_key: "viz_chart_id"
  belongs_to :creator, class_name: "User", foreign_key: "created_by"
  belongs_to :updator, class_name: "User", foreign_key: "updated_by"
  belongs_to :account

  #VALIDATIONS
  validates :title, presence: :true
  validates :data_filz_id, presence: :true
  validates :viz_chart_id, presence: :true
  validates :map, presence: :true, on: :update

  #CALLBACKS
  before_create :before_create_set
  before_save :before_save_set

  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS

  def headers
    JSON.parse(self.data_filz.content)[0]
  end

  def reference_map
    JSON.parse(self.viz_chart.mapping.gsub("'", '"'))
  end

  def generate_map
    map_json = JSON.parse(self.map).invert
    data = JSON.parse(self.data_filz.content)
    headings = data.shift
    headings = headings.collect{|h| h.split(":").first }
    
    json_data = [{"key" => "Chart","values" => []}]
    data.each do |row|
      h = {}
      label = row[headings.index(map_json["Data"])]
      value = row[headings.index(map_json["Value"])]
      el = false
      json_data[0]["values"].each_with_index do |set, i|
        if set["label"] == label
          el = i
        end
      end
      unless el
        h["label"] = label
        h["value"] = value.to_i
      else
        hash = json_data[0]["values"][el]
        hash["value"] += value.to_i
        json_data[0]["values"][el] = hash
      end
      if h != {}
        json_data[0]["values"].push(h);
      end
    end
    self.mapped_output = json_data
  end

  #UPSERT
  #JOBS
  #PRIVATE
  private

  def before_create_set
    self.created_by = User.current.id
    true
  end

  def before_save_set
    self.updated_by = User.current.id
    if self.map_changed?
      if self.map.present?
        self.generate_map
      end
    end
    true
  end

end
