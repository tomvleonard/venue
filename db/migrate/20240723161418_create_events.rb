class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string 'performer'
      t.datetime 'when'
      t.text 'content'
      t.timestamps
    end
  end
end
