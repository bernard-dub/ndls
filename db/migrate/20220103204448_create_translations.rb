class CreateTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :translations do |t|
      t.text :original
      t.text :translated
      t.integer :lesson_id

      t.timestamps
    end
  end
end
