class Permutation < ActiveRecord::Base
  #serialize :permutation, JSON

  belongs_to :user

  validates :permutation, presence: true
end
