class AddCodeToUseCase < ActiveRecord::Migration
  def change
    add_column :use_cases, :code, :string
  end
end
