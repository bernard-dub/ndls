class CreateTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :translations do |t|
      t.string :original
      t.string :translated
      t.integer :lesson_id

      t.timestamps
    end
  end
end
