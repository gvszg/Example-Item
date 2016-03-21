class Road < ActiveRecord::Base
  belongs_to :town
  has_many :stores
end