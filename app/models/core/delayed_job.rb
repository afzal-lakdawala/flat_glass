class Core::DelayedJob < ActiveRecord::Base
  
  #GEMS USED
  self.table_name = :delayed_jobs
  
  #ACCESSORS
  #ASSOCIATIONS
  #VALIDATIONS
  #CALLBACKS
  #SCOPES
  scope :bug,       where("last_error is not null")
  scope :ok,        where("last_error is null")
  scope :active,    where("locked_at is not null")
  
  #CUSTOM SCOPES  
  #OTHER METHODS  
  
  def status
    if !last_error.blank?
      return "<span class='red'>Error</span>".html_safe
    elsif last_error.blank? and locked_at.blank?
      return "<span style='color: orange;'>In Queue</span>".html_safe
    elsif last_error.blank? and !locked_at.blank?
      return "<span class='green'>Running</span>".html_safe
    end
  end
  
  #PRIVATE
  private
  
end