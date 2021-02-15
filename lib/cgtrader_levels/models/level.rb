# frozen_string_literal: true

module CgtraderLevels
  class Level < ActiveRecord::Base
    validates :experience, numericality: { greater_than_or_equal_to: 0 }
  end
end
