class RenameWhenToEventDateInEvents < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :when, :event_date
  end
end
