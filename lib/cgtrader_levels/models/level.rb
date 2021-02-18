# frozen_string_literal: true

module CgtraderLevels
  class Level < ActiveRecord::Base
    has_many :users

    validates :experience, presence: true, numericality: { greater_than_or_equal_to: 0 }, uniqueness: true
    validates :coins_bonus, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :tax_reduction, presence: true, numericality: { greater_than_or_equal_to: 0 }
  end
end
