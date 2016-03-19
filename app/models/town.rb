class Town < ActiveRecord::Base
  belongs_to :county
  has_many :roads
  has_many :stores
end