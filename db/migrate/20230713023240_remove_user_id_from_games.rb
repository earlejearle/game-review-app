class RemoveUserIdFromGames < ActiveRecord::Migration[6.1]
  def change
    remove_column :games, :user_id, :integer
  end
end
