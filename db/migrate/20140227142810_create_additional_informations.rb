class CreateAdditionalInformations < ActiveRecord::Migration
  def change
    create_table :additional_informations do |t|
      t.string :operating_system
      t.string :collection_point
      t.string :optional
      t.string :description
      t.datetime :deferred_date
      t.string :postman_name
      t.string :postman_version

      t.timestamps
    end
  end
end
