class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons do |t|
      t.text :title

      t.timestamps
    end
  end
end
