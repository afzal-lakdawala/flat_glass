class Cms::Article < ActiveRecord::Base
  
  #GEMS USED
  self.table_name = :cms_articles
  extend FriendlyId
  friendly_id :title, use: [:slugged, :scoped], scope: :account
  #has_attached_file :file
  has_paper_trail

  
  #ACCESSORS
  attr_accessible :account_id, :created_by, :description, :is_published, :published_at, :title, :updated_by
  
  #ASSOCIATIONS
  belongs_to :creator, :class_name => 'User', :foreign_key => "created_by"
  belongs_to :updator, :class_name => 'User', :foreign_key => "updated_by"
  belongs_to :account
  
  #VALIDATIONS
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
    g = @account.cms_articles.where(:title => self.name).first
    if g.present?
      if g.id != self.id or self.id.blank?
        errors.add(:title, "already taken")
      end
    end
  end
  
  def before_save_set
    self.updated_by = User.current.id
    if self.is_published_changed?
      if self.is_published
        self.published_at = Date.today
      end
    end
    true
  end
  
  def before_create_set
    self.created_by = User.current.id
    self.is_published = false if self.is_published.blank?
    true
  end
    
end
