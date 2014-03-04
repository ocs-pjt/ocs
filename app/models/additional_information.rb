class AdditionalInformation < ActiveRecord::Base

  def self.create_from_params(operating_system, object, deferred)
    self.create!(
      operating_system: operating_system,
      collection_point: object[:collection_point],
      optional:         object[:optional],
      description:      object[:description],
      deferred_date:    deferred && deferred[:date],
      postman_name:     deferred && deferred[:postman_name],
      postman_version:  deferred && deferred[:postman_version]
    ) 
  end

end
