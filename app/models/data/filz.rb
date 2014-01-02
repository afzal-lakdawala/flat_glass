class Data::Filz < ActiveRecord::Base

  #GEMS USED
  require 'roo'
  require 'csv'
  self.table_name = :data_filzs

  extend FriendlyId
  friendly_id :file_file_name, use: [:slugged, :scoped], scope: :account
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
  validate :is_content_valid?
  validate :is_name_unique?
  validate :atleast_two_rows?

  #CALLBACKS
  before_save :before_save_set
  before_create :before_create_set
  after_save :after_save_set

  #SCOPES
  scope :license, where(genre: "license")
  scope :readme, where(genre: "readme")

  #CUSTOM SCOPES
  #OTHER METHODS
  def self.remove_nil_rows(contenz)
    con = contenz.class.to_s == "String" ? JSON.parse(contenz) : contenz

    con.delete_if{ |row| row.flatten.compact.empty? }
    con = con.transpose
    con.delete_if{ |row| row.flatten.compact.empty? }
    con = con.transpose

    return con

#     i = 0
#     delete_rows = []
#     con.each do |row|
#       flag = true
#       row.each do |element|
#         if (element.class.to_s == "Array" and !element.compact.empty?) or (element.class.to_s != "Array" and !element.nil?)
#             flag = false
#             break
#         end
#       end
#       delete_rows << i if flag
#       i = i + 1
#     end
#     delete_rows.sort.reverse!.each do |j|
#       con.delete_at(j)
#     end
#     con
  end

  #UPSERT
  #JOBS
  #PRIVATE
  private

  def is_name_unique?
    g = self.account.data_filzs.where(file_file_name: self.file_file_name, category: self.category).first
    if g.present?
      if g.id != self.id or self.id.blank?
        errors.add(:file_file_name, "already taken")
      end
    end
  end

  def is_content_valid?
    self.updated_by = User.current.id if User.current.present?
    if self.content.present? and self.genre != "readme" and self.genre != "license"
      con = Data::Filz.remove_nil_rows(self.content)

      if con.count < 2
        errors.add(:content, "Insert minimum Two rows")
      else
        new_header = Data::FilzColumn.get_headers(con)
        newa = []
        newa = [new_header.split(",")] + con
        con = newa
        self.content = con.to_json
      end
    end
    true
  end

  def atleast_two_rows? #version0.2_TODO
    true
  end

  def before_create_set
    self.created_by = User.current.id if User.current.present?
    self.commit_message = "First commit"  if self.commit_message.blank?
    self.is_pending = false if self.is_pending.blank?
    self.file_content_type = "csv" if self.file_content_type.blank?
    self.category = "data" if self.category.blank?
    true
  end

  def before_save_set
  end

  def after_save_set
    if self.genre == "license" and self.category_changed?
      self.account.update_attributes(license: self.category)
    end
    true
  end

end
