class Analysis < ApplicationRecord
  belongs_to :page
  has_many :messages
end
