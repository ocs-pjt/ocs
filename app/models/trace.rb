class Trace < ActiveRecord::Base
  include Concerns::Shared

  belongs_to :use_case
  belongs_to :additional_information

  facet :created_from, field_name: 'traces.created_at', where: '>= {{value}}'
  facet :created_to, field_name: 'traces.created_at', where: '<= {{value}}'
  facet :tag_ids, field_name: 'tags.id'

end
