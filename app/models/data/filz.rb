class Data::Filz < ActiveRecord::Base
  
  #GEMS USED
  require 'roo'
  self.table_name = :data_filzs
  
  extend FriendlyId
  friendly_id :file_file_name, use: [:slugged, :scoped], scope: :account
  #has_attached_file :file
  has_paper_trail
  
  #ACCESSORS
  attr_accessible :account_id, :content, :created_by, :error_log, :genre, :is_pending, :updated_by, :file_content_type, :file_file_name, :file_file_size, :category, :commit_message
  
  #ASSOCIATIONS
  belongs_to :creator, class_name: "User", foreign_key: "created_by"
  belongs_to :updator, :class_name => 'User', :foreign_key => "updated_by"
  belongs_to :api_filz, class_name: "Api::Filz", foreign_key: "data_filz_id", dependent: :destroy
  belongs_to :account
  
  #VALIDATIONS
  validates :file_file_name, length: {minimum: 5}, presence: true
  #validates :file_content_type, length: {minimum: 2}, presence: true
  validates :content, length: {minimum: 5, message: "is too short (minimum is 5 rows)"}, allow_blank: true
  validate :has_unique_file_name?, on: :create
  
  #CALLBACKS
  before_create :before_create_set
  after_save :after_save_set
  
  #SCOPES
  scope :license, where(genre: "license")
  scope :readme, where(genre: "readme")  
  
  #CUSTOM SCOPES
  #OTHER METHODS  
  
  def self.csv_to_handsontable(csv)
    str = ""
    return str
  end
  
  def handsontable_to_csv
    str = self.content
    return str
  end
  
  #UPSERT
  #JOBS
  #PRIVATE
  private
  
  def has_unique_file_name?
    if Data::Filz.where(file_file_name: self.file_file_name, category: self.category, account_id: self.account_id).first.present?
      errors.add(:file_file_name, "already taken")
    end
  end

  def before_create_set
    self.created_by = User.current.id if self.id.blank?
    self.updated_by = User.current.id
    self.is_pending = false           if self.is_pending.blank?
    true
  end
  
  def after_save_set
    if self.genre == "license" and self.category_changed?
      self.account.update_attributes(license: self.category)
    end
    if self.content.present?
      JSON.parse(self.content).first.each do |col|
        
      end
    end
    true    
  end
  
end