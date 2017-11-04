class Message < ApplicationRecord
  belongs_to :analysis
  has_one :element
end
