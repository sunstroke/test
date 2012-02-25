class CreateCatalogues < ActiveRecord::Migration
  def change
    create_table :catalogues do |t|
      t.boolean :mainfoto
      t.string :name
      t.string :foto1
      t.string :foto2
      t.string :foto3
      t.integer :width
      t.integer :height
      t.integer :depth
      t.integer :count
      t.string :art
      t.integer :rent
      t.integer :purchase
      t.integer :transportation
      t.integer :installation
      t.integer :dismantling
      t.integer :fine
      t.text :desc

      t.timestamps
    end
  end
end
