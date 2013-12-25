class Cms::Image < ActiveRecord::Base
  
  #GEMS USED
  self.table_name = :cms_images
  extend FriendlyId
  friendly_id :title, use: [:slugged, :scoped], scope: :account
  has_paper_trail
  #has_attached_file :image, styles: { :small => "20x20>", :original => "500x500>" }, :storage => :database, url: "/:user_id/:account_id/images/:file_id/i?style=:style"

  #ACCESSORS
  attr_accessible :account_id, :created_by, :updated_by, :slug, :image_file, :title, :image_content_type, :image_file_name, :image_file_size
  
  #ASSOCIATIONS
  belongs_to :creator, :class_name => 'User', :foreign_key => "created_by"
  belongs_to :updator, :class_name => 'User', :foreign_key => "updated_by"
  belongs_to :account
  
  #VALIDATIONS
  validates :title, presence: true, length: {minimum: 1}
  validate :is_name_unique?
  validates_attachment :image, :presence => true,
    :content_type => { :content_type => ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'] }
    #,:size => { :in =>  5.megabytes }
    
  #CALLBACKS  
  before_create :before_create_set
  before_save :before_save_set
  before_post_process :image?, :if => :if_avatar_changed?
  
  #SCOPES
  #CUSTOM SCOPES
  #OTHER METHODS  
  #UPSERT
  #JOBS
  #PRIVATE
  private
  
  def image?
    !(image_content_type =~ /^image.*/).nil?
  end
  
  def if_avatar_changed?
    (self.image_file_name_changed? or self.image_content_type_changed? or self.image_file_size_changed?) ? true : false
  end
  
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
    true
  end
  
  def before_create_set
    self.created_by = User.current.id
    true
  end
  
end
