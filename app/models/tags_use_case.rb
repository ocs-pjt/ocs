class TagsUseCase < ActiveRecord::Base
  belongs_to :tag
  belongs_to :use_case
end
