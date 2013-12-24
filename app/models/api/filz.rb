#TODO - Fails when we try to delete Api::Filz from Rails
class Api::Filz < ActiveRecord::Base

  #GEMS USED
  self.table_name = :api_filzs
  
  #CONSTANTS
  #ACCESSORS
  attr_accessible :account_id, :api_account_id, :api_account_name, :data_filz_id, :error_string, :last_requested_at, :last_requested_by, :status, :data_query_id #, :user_id
  
  #ASSOCIATIONS
  belongs_to :data_filz, class_name: "Data::Filz", foreign_key: "data_filz_id", dependent: :destroy
  belongs_to :data_query, class_name: "Data::Query", foreign_key: "data_query_id", dependent: :destroy
  belongs_to :api_account, class_name: "Api::Account", foreign_key: "api_account_id", dependent: :destroy
  belongs_to :account
  #belongs_to :user
  belongs_to :requestor, class_name: "User", foreign_key: "last_requested_by"
  
  #VALIDATIONS
  validate :check_uniqueness, on: :create
  
  #CALLBACKS
  before_create :before_create_set
  after_create :after_create_set
  
  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS
  #UPSERT  
  def self.upsert(aid, aaid, dqid)    
    a = Api::Filz.where(account_id: aid, data_query_id: dqid, api_account_id: aaid).first
    a = Api::Filz.new(account_id: aid, data_query_id: dqid, api_account_id: aaid) if a.blank?
    a.save
  end
  
  #JOBS
  #PRIVATE
  private
  
  def check_uniqueness
    g = Api::Filz.where(account_id: self.account_id, api_account_id: self.api_account_id, data_query_id: self.data_query_id).first
    errors.add(:data_query_id, "Query already exists.")   if g.present?
  end
  
  def before_create_set
    self.api_account_name = self.api_account.name
    self.last_requested_at = Time.now
    self.status = "New"
    self.last_requested_by = User.current.id if User.current.present?
    d = Data::Filz.new(:account_id => self.account_id, :genre => "API", :is_pending => true, :file_file_name => "#{self.data_query.source_s}: #{self.data_query.name}", :category => "data", :commit_message => "First pull")
    d.save
    self.data_filz_id = d.id
    true
  end
  
  def after_create_set
    Jobs::Ga.delay.query(self.id, "first")
    true
  end
    
end
