class AddPositionToCatalogue < ActiveRecord::Migration
  def change
    add_column :catalogues, :position, :integer
    add_column :catalogues, :visible, :boolean
    add_column :catalogues, :print, :boolean
  end
end
