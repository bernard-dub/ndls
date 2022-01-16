class AddProfanityToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profanity, :text, default: 'neutre'
    User.update_all(profanity:'neutre')
  end
end
