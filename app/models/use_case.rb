class UseCase < ActiveRecord::Base
  belongs_to :user
  belongs_to :collector_version
  belongs_to :program
  belongs_to :program_version

  has_one :collector, through: :collector_version

  has_many :tags_use_cases
  has_many :tags, through: :tags_use_cases
  has_many :permutations

  validates :key, :user, presence: true

  scope :with_params, -> (user_id, collector_version_id, program_id) do 
    where(user_id: user_id, collector_version_id: collector_version_id, program_id: program_id) 
  end
  
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

  def self.get_new_key(user_id, collector_version_id, program_id, tags)
    u = self.new(user_id: user_id, collector_version_id: collector_version_id, program_id: program_id)
    u.tags << tags if tags
    u.key = SecureRandom.hex
    u
    u.key if u.save! 
  end

end
