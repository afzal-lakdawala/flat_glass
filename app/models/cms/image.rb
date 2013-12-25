class Cms::Image < ActiveRecord::Base
  
  #GEMS USED
  self.table_name = :cms_images
  extend FriendlyId
  friendly_id :image_file_name, use: [:slugged, :scoped], scope: :account
  #has_attached_file :file
  has_paper_trail

  #ACCESSORS
  attr_accessible :account_id, :created_by, :image_content_type, :image_file_name, :image_file_size, :updated_by, :slug
  
  #ASSOCIATIONS
  belongs_to :creator, :class_name => 'User', :foreign_key => "created_by"
  belongs_to :updator, :class_name => 'User', :foreign_key => "updated_by"
  belongs_to :account
  
  #VALIDATIONS
  validates :name, presence: true, length: {minimum: 1}
  validate :is_name_unique?
  
  #CALLBACKS  
  before_create :before_create_set
  before_save :before_save_set
  
  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS  
  #UPSERT
  #JOBS
  #PRIVATE
  private
  
  def is_name_unique?
    g = @account.cms_images.where(image_file_name: self.name).first
    if g.present?
      if g.id != self.id or self.id.present?
        errors.add(:image_file_name, "already taken")
      end
    end
  end
  
  def before_save_set
    self.updated_by = User.current.id
    true
  end
  
  def before_create_set
    self.created_by = User.current.id
    true
  end
  
end
