class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.references :test, null: false, foreign_key: true
      t.references :translation, null: false, foreign_key: true
      t.string :content
      t.boolean :correct

      t.timestamps
    end
  end
end
