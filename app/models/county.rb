class County < ActiveRecord::Base
  has_many :towns
  has_many :stores
end