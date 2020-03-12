class Event < ApplicationRecord
  validates :schema, :action, presence: :true
end
