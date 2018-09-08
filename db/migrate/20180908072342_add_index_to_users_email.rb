class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
  end
  add_index :users, :email, unique: true
end
