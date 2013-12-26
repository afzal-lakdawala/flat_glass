class Cms::Image < ActiveRecord::Base
  
  #GEMS USED
  self.table_name = :cms_images
  extend FriendlyId
  friendly_id :title, use: [:slugged, :scoped], scope: :account
  has_paper_trail
  mount_uploader :image_file, ImageUploader
  
  #ACCESSORS
  attr_accessible :account_id, :created_by, :updated_by, :slug, :image_file, :title, :image_content_type, :image_file_size, :url
  
  #ASSOCIATIONS
  belongs_to :creator, :class_name => 'User', :foreign_key => "created_by"
  belongs_to :updator, :class_name => 'User', :foreign_key => "updated_by"
  belongs_to :account
  
  #VALIDATIONS
  validates :title, presence: true, length: {minimum: 1}
  validate :is_name_unique?
  validates :image_file, :presence => true#, :file_size => { :maximum => 5.megabytes.to_i } 
    
  #CALLBACKS  
  before_create :before_create_set
  before_save :before_save_set
  after_create :after_create_set
  
  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS  
  #UPSERT
  #JOBS
  #PRIVATE
  private
  
  def is_name_unique?
    g = self.account.cms_images.where(title: self.title).first
    if g.present?
      if g.id != self.id or self.id.blank?
        errors.add(:title, "already taken")
      end
    end
  end
  
  def before_save_set
    self.updated_by = User.current.id
    if image_file.present? && image_file_changed?
      self.image_content_type = image_file.file.content_type
      self.image_file_size = image_file.file.size
    end
    true
  end
  
  def before_create_set
    self.created_by = User.current.id
    true
  end
  
  def after_create_set
    self.update_attributes(url: self.image_file_url)
    true
  end
  
end
