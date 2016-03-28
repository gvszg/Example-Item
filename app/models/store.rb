class Store < ActiveRecord::Base
  belongs_to :county
  belongs_to :town
  belongs_to :road
end