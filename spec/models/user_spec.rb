require 'spec_helper'

describe CgtraderLevels::User do
  describe 'new user' do
    let!(:level) { CgtraderLevels::Level.create!(experience: 0, title: 'First level') }
    let(:user) { CgtraderLevels::User.new }

    it 'has 0 reputation points' do
      expect(user.reputation).to be_zero
    end

    it "has assigned 'First level'" do
      expect(user.level).to eq(level)
    end
  end

  describe 'level up' do
    let!(:level_1) { CgtraderLevels::Level.create!(experience: 0, title: 'First level') }
    let!(:level_2) { CgtraderLevels::Level.create!(experience: 10, title: 'Second level') }
    let!(:level_3) { CgtraderLevels::Level.create!(experience: 13, title: 'Third level') }
    let(:user) { CgtraderLevels::User.create! }

    it "levels up from 'First level' to 'Second level'" do
      expect {
        user.update_attribute(:reputation, 10)
      }.to change { user.reload.level }.from(level_1).to(level_2)
    end

    it "levels up from 'First level' to 'Second level'" do
      expect {
        user.update_attribute(:reputation, 11)
      }.to change { user.reload.level }.from(level_1).to(level_2)
    end
  end

  describe 'level up bonuses & privileges' do
    let!(:level_1) { CgtraderLevels::Level.create!(experience: 0, title: 'First level') }
    let!(:level_2) { CgtraderLevels::Level.create!(experience: 10, title: 'Second level') }
    let(:user) { CgtraderLevels::User.create!(coins: 1) }

    it 'gives 7 coins to user' do
      expect {
        user.update_attribute(:reputation, 10)
      }.to change { user.reload.coins }.by(7)
    end

    it 'reduces tax rate by 1' do
      expect {
        user.update_attribute(:reputation, 10)
      }.to change { user.reload.tax }.by(-1)
    end
  end
end
