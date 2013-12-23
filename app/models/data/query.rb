class Data::Query < ActiveRecord::Base
  
  #GEMS USED
  self.table_name = :data_queries
  
  #ACCESSORS
  attr_accessible :description, :dimensions, :header_row, :metrics, :name, :source
  attr_accessor :is_oauth_done, :is_used
  
  #ASSOCIATIONS
  has_many :api_filzs, class_name: "Api::Filz", dependent: :destroy, foreign_key: "api_filz_id"
  
  #VALIDATIONS
  validates :name, uniqueness: true, presence: true
  validates :metrics, presence: true
  validates :source, presence: true
  
  #CALLBACKS
  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS
  
  def self.all_(user, account)
    a = Data::Query.all
    a.each do |query|
      query.is_oauth_done = query.is_oauth_done?(user)
      query.is_used = query.is_used?(account)
    end
    return a
  end
  
  def is_oauth_done?(user)
    user.api_oauths.where(app: self.source).first.present? ? true : false
  end
  
  def is_used?(account)
    account.api_filzs.where(data_query_id: self.id).first.present? ? true : false
  end
  
  def self.query_1(formatted_output)
    json_output = JSON.parse(formatted_output)
    json_output.each do |j|
      j["16"] = j["0"][0..3]
      j["17"] = j["0"][4..5]
      j["18"] = j["0"][6..7]
      j["19"] = j["2"].split("/")[0].strip
      j["20"] = j["2"].split("/")[1].strip
    end
    return json_output.to_s
  end
  
  #developers.google.com/analytics/devguides/reporting/core/dimsmets
  #ga(token, sd, ed, profile_id)
  def ga(token, sd, ed, profile_id)
    begin
      url = "https://www.googleapis.com/analytics/v3/data/ga?access_token=#{token}&start-date=#{sd}&end-date=#{ed}&ids=ga:#{profile_id}&metrics=#{self.metrics}"
      url = url + "&dimensions=#{self.dimensions}"  if self.dimensions.present?
      a = Core::Services.get_json(Nestful.get(url))
      if a.present?
        if a["totalsForAllResults"].present?
          return dimensions.blank? ? a["totalsForAllResults"] : a["rows"]
        end
      end
      return nil
    rescue => e
      return {status: "fail", message: e.inspect}
    end
  end
  
  def source_s
    source == "GA" ? "Google Analytics" : ""
  end
  
  #UPSERT
  #JOBS
  
  def self.seed
    Data::Query.create!(name: "Query 1", source: "GA", metrics: "ga:visitors,ga:newVisits,ga:visits,ga:bounces,ga:avgTimeOnSite,ga:pageviewsPerVisit,ga:pageviews,ga:avgTimeOnPage,ga:exits", dimensions: "ga:date,ga:country,ga:sourceMedium,ga:keyword,ga:deviceCategory,ga:pagePath,ga:landingPagePath", header_row: "{\"0\":\"date\", \"1\":\"country\", \"2\":\"sourceMedium\", \"3\":\"keyword\", \"4\":\"deviceCategory\", \"5\":\"pagePath\", \"6\":\"landingPagePath\", \"7\":\"visitors\", \"8\":\"newVisits\", \"9\":\"visits\", \"10\":\"bounces\", \"11\":\"avgTimeOnSite\", \"12\":\"pageviewsPerVisit\", \"13\":\"pageviews\", \"14\":\"avgTimeOnPage\", \"15\":\"exits\",\"16\":\"year\",\"17\":\"month\",\"18\":\"day\",\"19\":\"source\",\"20\":\"medium\"}", description: "adnfldaknf adlfkn adlf nadfl adkfn")
  end
    
  #PRIVATE
  private
  
end