class Tag < ActiveRecord::Base
  
  has_many :tags_use_cases
  has_many :use_cases, through: :tags_use_cases
  
  validates :name, presence: true
  validates :name, uniqueness: true

  scope :with_ids, ->(ids) { ids.try(:map) { |tag_id| Tag.find(tag_id) } }

  def self.find_or_create_tags(tag_names)
    tag_names.map do |tag_name|
      Tag.find_or_create_by!(name: tag_name)
    end if tag_names
  end


  def self.tag_names_from_str(tag_names_str)
    tag_names_str.try(:split, ",").try(:map, &:strip)
  end

end
