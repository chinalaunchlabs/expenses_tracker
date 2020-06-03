class RenameTypeInRecords < ActiveRecord::Migration[5.2]
  def change
    rename_column :records, :type, :record_type
  end
end
