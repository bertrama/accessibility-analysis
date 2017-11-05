class Analysis < ApplicationRecord
  belongs_to :page
  has_many :messages
  has_attached_file :screenshot
  do_not_validate_attachment_file_type :screenshot
end
