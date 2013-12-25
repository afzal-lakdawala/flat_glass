class Core::Tag < ActiveRecord::Base
  attr_accessible :account_id, :description, :genre, :name, :taggable_id, :taggable_type
end
