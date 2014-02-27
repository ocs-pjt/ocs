class RegularExpression < ActiveRecord::Base
  include Concerns::Shared
  
  belongs_to :use_case
  belongs_to :additional_information

  validates :additional_information, :use_case, presence: true

  facet :created_from, field_name: 'regular_expressions.created_at', where: '>= {{value}}'
  facet :created_to, field_name: 'regular_expressions.created_at', where: '<= {{value}}'
  facet :tag_ids, field_name: 'tags.id'
  
end
