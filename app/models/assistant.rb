class Assistant < ActiveRecord::Base
  scope :recent, lambda { order(id: :DESC) }

  scope :priority, lambda { order(position: :ASC) }

  enum status: { confirmed: 0, denied: 1 }

  acts_as_paranoid

  has_secure_password
end