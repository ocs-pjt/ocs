class Permutation < ActiveRecord::Base
  belongs_to :user

  validates :permutation, presence: true
end
