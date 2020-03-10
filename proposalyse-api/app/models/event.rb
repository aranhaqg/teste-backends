# == Schema Information
#
# Table name: events
#
#  id         :string           not null
#  schema     :string           not null
#  action     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Event < ApplicationRecord
  validates :schema, :action, presence: :true
end
