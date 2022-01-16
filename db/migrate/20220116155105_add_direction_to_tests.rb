class AddDirectionToTests < ActiveRecord::Migration[7.0]
  def change
    add_column :tests, :reverse, :boolean, default: false
    Test.update_all(reverse: false)
  end
  
end
