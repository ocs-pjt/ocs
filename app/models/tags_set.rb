class TagsSet < ActiveRecord::Base
  has_and_belongs_to_many :tags_sets
  has_and_belongs_to_many :programs
end
