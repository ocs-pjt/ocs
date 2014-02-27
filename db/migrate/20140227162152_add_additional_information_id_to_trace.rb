class AddAdditionalInformationIdToTrace < ActiveRecord::Migration
  def change
    add_column :traces, :additional_information_id, :integer
  end
end
