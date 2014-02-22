class User < ActiveRecord::Base
  
  #GEMS USED
  extend FriendlyId
  friendly_id :username, use: :slugged
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_paper_trail

  #ACCESSORS
  attr_accessible :email, :password, :remember_me, :name, :authentication_token, :bio, :time_zone, :username

  #ASSOCIATIONS

  #VALIDATIONS
  validates :email, uniqueness: {case_sensitive: false}, length: {minimum: 5}, format: {with: Pyk::Regex::EMAIL, message: "invalid format"}, presence: true
  validates :username, presence: true, length: {minimum: 5}
  validates_format_of :username, :with => /^[A-Za-z\d_]+$/
  validates :password , length: { within: 8..40, on: :create }, presence: {on: :create}

  #CALLBACKS
  before_create :before_create_set
  
  #SCOPES  
  #CUSTOM SCOPES
  #OTHER METHODS
  # Current user data setting from session to use in model  
  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end
  

  #UPSERT
  
  def to_s
    self.username
  end
  
  #JOBS
  #PRIVATE
  private
  
  def before_create_set
    self.authentication_token = SecureRandom.hex #set a secure random API key to each user
    true
  end
    
end
