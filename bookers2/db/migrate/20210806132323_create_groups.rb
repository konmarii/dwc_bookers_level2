class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :introduction
      t.string :image_id
      t.integer :owner_id
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
