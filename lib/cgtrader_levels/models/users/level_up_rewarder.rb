# frozen_string_literal: true

module CgtraderLevels
  module Users
    class LevelUpRewarder
      attr_reader :user, :new_level

      def initialize(user, new_level)
        @user = user
        @new_level = new_level
      end

      def execute
        level_ups = level_ups_count(new_level)
        user.coins += 7 * level_ups
        user.tax -= 1 * level_ups
      end

      private

      def level_ups_count(new_level)
        CgtraderLevels::Level.where(experience: user.level.experience...new_level.experience).count
      end
    end
  end
end
