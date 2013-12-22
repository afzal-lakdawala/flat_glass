class Api::File < ActiveRecord::Base

  #GEMS USED
  self.table_name = :api_files
  
  #CONSTANTS
  #ACCESSORS
  attr_accessible :account_id, :api_account_id, :api_account_name, :data_file_id, :error_string, :last_requested_at, :last_requested_by, :status, :user_id, :data_query_id
  
  #ASSOCIATIONS
  belongs_to :account
  belongs_to :user
  belongs_to :api_account, class_name: "Api::Account", foreign_key: "api_account_id", dependent: :destroy
  belongs_to :data_file, class_name: "Data::File", foreign_key: "data_file_id", dependent: :destroy
  belongs_to :data_query, class_name: "Data::Query", foreign_key: "data_query_id", dependent: :destroy
  belongs_to :requestor, class_name: "User", foreign_key: "last_requested_by"
  
  #VALIDATIONS
  validate :check_uniqueness, on: :create
  
  #CALLBACKS
  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS
  #UPSERT
  def self.upsert(aid, dq)
    
    Api::File.where(account_id: aid, data_query_id: dq.id, api_account_id: _, )
    
    
  end
  
  #JOBS
  #PRIVATE
  private
  
  def check_uniqueness
    g = Api::File.where(api_account_id: self.api_account_id, data_file_id: self.data_file_id).first
    if g.present?
      errors.add(:data_file_id, "file already exists.")
    end
  end
  
  
end
