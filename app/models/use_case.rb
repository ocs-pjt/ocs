class UseCase < ActiveRecord::Base
  belongs_to :user
  belongs_to :collector_version
  belongs_to :program
  belongs_to :program_version

  has_one :collector, through: :collector_version

  has_many :tags_use_cases
  has_many :tags, through: :tags_use_cases
  has_many :permutations
  has_many :traces
  has_many :regular_expressions

  validates :key, :user, presence: true

  scope :with_params, ->(user_id, collector_version_id, program_id) do 
    where(user_id: user_id, collector_version_id: collector_version_id, program_id: program_id) 
  end
  
  scope :with_tags, ->(tags) do 
    set = Set.new(tags.map(&:name))
    with_set_tag_names(set)
  end

  scope :with_tag_names, ->(tag_names) do 
    set = Set.new(tag_names)
    with_set_tag_names(set)
  end

  scope :with_set_tag_names, ->(set_tag_names) do
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

  def self.with(use_case_params)
    with_params(use_case_params[:user_id], use_case_params[:collector_version_id], use_case_params[:program_id]).
      with_tag_names(use_case_params[:tag_names]).
      first
  end

  def self.with_params_tags(use_case_params)
    with_params(use_case_params[:user_id], use_case_params[:collector_version_id], use_case_params[:program_id]).
      with_tags(use_case_params[:tags]).
      first
  end

end
