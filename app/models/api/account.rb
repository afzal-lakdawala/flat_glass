class Api::Account < ActiveRecord::Base
  
  #GEMS USED
  self.table_name = :api_accounts
  
  #CONSTANTS
  GA_URL = "https://www.googleapis.com/analytics/v3/management/accounts"
  
  #ACCESSORS
  attr_accessible :api_oauth_id, :name, :api_profile_id, :user_id, :api_account_id
  
  #ASSOCIATIONS
  belongs_to :api_oauth, class_name: "Api::Oauth", foreign_key: "api_oauth_id"
  belongs_to :user
  has_many :api_filzs, class_name: "Api::Filz", foreign_key: "api_account_id", dependent: :destroy
  
  #VALIDATIONS
  validates :name, presence: :true
  validates :api_oauth_id, presence: :true
  validates :api_profile_id, presence: :true
  validates :user_id, presence: :true
  validates :api_account_id, presence: :true
  validate  :check_uniqueness, on: :create
  
  #CALLBACKS
  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS
  def self.get_accounts(oauth)
    begin
      oauth.reauthenticate?
      token = "access_token=#{oauth.token}"
      url = "#{GA_URL}?#{token}"
      a = Core::Services.get_json(Nestful.get(url))
      if a.present?
        if a["items"].first.present?
          a["items"].each do |account|
            if account["id"].present?
              url2 = "#{account["selfLink"]}/webproperties/UA-#{account["id"]}-1/profiles?#{token}"
              p = Core::Services.get_json(Nestful.get(url2))
              if p.present?
                if p["items"].first.present?
                  profile = p["items"].first
                  Api::Account.create!(user_id: User.current.id, 
                                       api_oauth_id: oauth.id, 
                                       name: account["name"], 
                                       api_account_id: account["id"], 
                                       api_profile_id: profile["id"])
                end
              end
            end
          end
        end  
      end
      return nil
    rescue Exception => ex
      return ex.message.to_s
    end
  end
  
  #UPSERT
  #JOBS
  #PRIVATE
  private
  
  def check_uniqueness
    g = Api::Account.where(user_id: self.user_id, api_oauth_id: self.api_oauth_id, name: self.name, api_profile_id: self.api_profile_id, api_account_id: self.api_account_id).first
    if g.present?
      errors.add(:name, "already exists.")
    end
  end
  
end
