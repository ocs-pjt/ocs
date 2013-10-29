class Permutation #< ActiveRecord::Base
  #belongs_to :user
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :permutation,   type: String
  field :name,          type: String
  field :collector_id,  type: Integer
  field :user_id,       type: Integer
  field :use_case_id,   type: Integer

  validates :permutation, presence: true
end
