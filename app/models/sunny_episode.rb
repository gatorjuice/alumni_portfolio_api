# frozen_string_literal: true

class SunnyEpisode < ApplicationRecord
  has_many :wins,
           class_name: 'SunnyEpisodeUserRanking',
           foreign_key: :better_episode_id,
           inverse_of: :better_episode,
           dependent: :destroy
  has_many :losses,
           class_name: 'SunnyEpisodeUserRanking',
           foreign_key: :worse_episode_id,
           inverse_of: :worse_episode,
           dependent: :destroy

  validates :number, uniqueness: true
  validates :episode, uniqueness: { scope: :season }

  scope :random_two, -> { order('RANDOM()').limit(2) }

  scope :top_ten, lambda {
    joins(:wins)
      .group(:id)
      .order('COUNT(better_episode_id) DESC')
      .limit(10)
  }

  scope :bottom_ten, lambda {
    joins(:losses)
      .group(:id)
      .order('COUNT(worse_episode_id) DESC')
      .limit(10)
  }
end
