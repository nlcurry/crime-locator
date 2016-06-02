class AddCompleteAddressToQuery < ActiveRecord::Migration
  def change
    add_column :queries, :address, :string
    add_column :queries, :city, :string, default: "Seattle"
    add_column :queries, :state, :string, default: "WA"
  end
end
