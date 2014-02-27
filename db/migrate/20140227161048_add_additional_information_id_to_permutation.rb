class AddAdditionalInformationIdToPermutation < ActiveRecord::Migration
  def change
    add_column :permutations, :additional_information_id, :integer
  end
end
