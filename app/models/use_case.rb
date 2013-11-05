class UseCase < ActiveRecord::Base
  belongs_to :user
  belongs_to :collector
  belongs_to :collector_version
  belongs_to :program
  belongs_to :program_version

  has_and_belongs_to_many :tags


  def program_name
    program.try(:name)
  end

  def program_version_version
    program_version.try(:version)
  end
end
