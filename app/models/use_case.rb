class UseCase < ActiveRecord::Base
  belongs_to :user
  belongs_to :collector
  belongs_to :collector_version
  belongs_to :program
  belongs_to :program_version

  has_and_belongs_to_many :tags

  validates :key, :user, :collector, presence: true

  scope :with_params , -> (user_id, collector_id, program_id) { where(user_id: user_id, collector_id: collector_id, program_id: program_id) } 

  scope :select_use_case_with_tags, -> (tags) do 
    set = Set.new(tags.map(&:name))
    select_use_case_with_set_tag_names(set)
  end

  scope :select_use_case_with_tag_names, -> (tag_names) do 
    set = Set.new(tag_names)
    select_use_case_with_set_tag_names(set)
  end

  scope :select_use_case_with_set_tag_names, -> (set_tag_names) do
    select do |use_case|
      Set.new(use_case.tags.map(&:name)) == set_tag_names
    end
  end

  def program_name
    program.try(:name)
  end

  def program_version_version
    program_version.try(:version)
  end

  def self.new_use_case_with_tags(user_id, collector_id, program_id, tags)
    u = UseCase.new(user_id: user_id, collector_id: collector_id, program_id: program_id)
    u.tags << tags if tags
    u.key = SecureRandom.hex
    u
  end

end
