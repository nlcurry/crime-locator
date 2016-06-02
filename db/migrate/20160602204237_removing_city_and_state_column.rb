class RemovingCityAndStateColumn < ActiveRecord::Migration
  def change
    remove_column :queries, :city, :string
    remove_column :queries, :state, :string
  end
end
