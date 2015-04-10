class AddCategoryidToCatalogues < ActiveRecord::Migration
  def change
    add_column :catalogues, :category_id, :integer
  end
end
