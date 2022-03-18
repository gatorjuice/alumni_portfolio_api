# frozen_string_literal: true

class CreateSunnyEpisodeUserRankings < ActiveRecord::Migration[6.1]
  def change
    create_table :sunny_episode_user_rankings do |t|
      t.integer :user_id
      t.integer :better_episode_id
      t.integer :worse_episode_id

      t.timestamps
    end

    add_index :create_sunny_episode_rankings, [:user_id, :better_episode_id, :worse_episode_id], unique: true
  end
end
