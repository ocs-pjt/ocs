class Permutation #< ActiveRecord::Base
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :permutation,   type: String
  field :name,          type: String
  field :user_id,       type: Integer
  field :collector_id,  type: Integer
  field :program_id,    type: Integer
  field :tags_ids,      type: String


  validates :permutation, presence: true


  def user
    User.find self.user_id
  end

  def collector
    Collector.find self.collector_id
  end

  def program
    Program.find self.program_id
  end

  def tags
    self.tags_ids.split(",").map { |id| Tag.find id }
  end

end
