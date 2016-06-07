class Message < ActiveRecord::Base
  scope :personal_message, -> { where(message_type: Message.message_types["個人訊息"]) }
  
  enum message_type: { "個人訊息": "0", "萌萌屋官方訊息": "1" }

  has_many :message_records, dependent: :destroy
  has_many :users, through: :message_records

  validates_presence_of :title, :content

  def self.messagr_type_lists
    self.message_types.to_a
  end
end