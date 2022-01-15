class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests do |t|
      t.references :lesson, null: false, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
