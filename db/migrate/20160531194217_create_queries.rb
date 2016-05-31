class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.float "latitude"
      t.float "longitude"

      t.timestamps null: false
    end
  end
end
