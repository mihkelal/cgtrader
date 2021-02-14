class CgtraderLevels::User < ActiveRecord::Base
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
    level_ups = level_ups_count(corresponding_level)
    self.coins += 7 * level_ups
    self.tax -= 1 * level_ups
  end

  def level_ups_count(corresponding_level)
    CgtraderLevels::Level.where(experience: self.level.experience...corresponding_level.experience).count
  end
end
