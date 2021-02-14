class CgtraderLevels::User < ActiveRecord::Base
  attr_reader :level

  after_initialize do
    self.reputation = 0
    set_corresponding_level
  end

  before_save do
    set_corresponding_level_and_grant_level_up_bonuses
  end

  private

  def set_corresponding_level
    corresponding_level = find_corresponding_level

    if corresponding_level
      self.level_id = corresponding_level.id
      @level = corresponding_level
    end
  end

  def set_corresponding_level_and_grant_level_up_bonuses
    new_corresponding_level = find_corresponding_level
    return if new_corresponding_level == self.level

    level_ups = level_ups_count(new_corresponding_level)
    self.coins += 7 * level_ups
    self.tax -= 1 * level_ups
    self.level_id = new_corresponding_level.id
    @level = new_corresponding_level
  end

  def find_corresponding_level
    CgtraderLevels::Level.where(experience: ..reputation).order(experience: :desc).first
  end

  def level_ups_count(corresponding_level)
    CgtraderLevels::Level.where(experience: self.level.experience...corresponding_level.experience).count
  end
end
