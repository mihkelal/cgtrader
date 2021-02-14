class CgtraderLevels::User < ActiveRecord::Base
  attr_reader :level

  after_initialize do
    self.reputation = 0

    corresponding_level = find_corresponding_level

    if corresponding_level
      self.level_id = corresponding_level.id
      @level = corresponding_level
    end
  end

  before_save :set_new_level

  private

  def set_new_level
    corresponding_level = find_corresponding_level

    if corresponding_level
      self.level_id = corresponding_level.id
      @level = corresponding_level
    end
  end

  def find_corresponding_level
    CgtraderLevels::Level.where(experience: ..reputation).order(experience: :desc).first
  end
end
