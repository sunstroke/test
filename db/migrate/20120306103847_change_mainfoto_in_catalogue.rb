class ChangeMainfotoInCatalogue < ActiveRecord::Migration
  def up
    change_column :catalogues, :mainfoto, :boolean, :default => "true"
  end

  def down
    change_column :catalogues, :mainfoto, :boolean
  end
end
