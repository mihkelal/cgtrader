# frozen_string_literal: true

module CgtraderLevels
  class User < ActiveRecord::Base
    belongs_to :level

    after_initialize do
      self.reputation ||= 0
      set_corresponding_level
    end

    before_save :set_corresponding_level_and_grant_level_up_bonuses

    private

    def set_corresponding_level
      self.level ||= find_corresponding_level
    end

    def set_corresponding_level_and_grant_level_up_bonuses
      new_corresponding_level = find_corresponding_level
      return if new_corresponding_level == self.level

      grant_level_up_bonuses(new_corresponding_level)
      self.level = new_corresponding_level
    end

    def find_corresponding_level
      CgtraderLevels::Level.where(experience: ..reputation).order(:experience).last
    end

    def grant_level_up_bonuses(corresponding_level)
      CgtraderLevels::Users::LevelUpRewarder.new(self, corresponding_level).execute
    end
  end
end
