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
        user.coins += level_ups.sum(&:coins_bonus)
        user.tax -= level_ups.sum(&:tax_reduction)
      end

      private

      def level_ups
        @level_ups ||= CgtraderLevels::Level.where(experience: (user.level.experience + 1)..new_level.experience)
      end
    end
  end
end
