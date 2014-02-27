class TagsUser < ActiveRecord::Base
  belongs_to :default_tag, class_name: "Tag", foreign_key: "tag_id"
  belongs_to :user
end
