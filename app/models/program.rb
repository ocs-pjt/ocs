class Program < ActiveRecord::Base
  has_and_belongs_to_many :tags_sets
  validates :name, presence: true
end
