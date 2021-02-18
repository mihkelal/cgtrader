# frozen_string_literal: true

require 'spec_helper'

describe CgtraderLevels::User do
  describe 'new user' do
    let!(:level1) { CgtraderLevels::Level.create!(experience: 0, title: 'First level') }
    let(:user) { CgtraderLevels::User.new }

    it 'has 0 reputation points' do
      expect(user.reputation).to be_zero
    end

    it "has assigned 'First level'" do
      expect(user.level).to eq(level1)
    end

    describe 'level up' do
      let!(:level2) { CgtraderLevels::Level.create!(experience: 10, title: 'Second level') }
      let!(:level3) { CgtraderLevels::Level.create!(experience: 13, title: 'Third level') }
      let(:user) { CgtraderLevels::User.create! }

      context 'with insufficient reputation' do
        it 'does not level up' do
          expect do
            user.update(reputation: 5)
          end.not_to change { user.reload.level }
        end
      end

      context 'with reputation equal to level experience' do
        it "levels up from 'First level' to 'Second level'" do
          expect do
            user.update(reputation: 10)
          end.to change { user.reload.level }.from(level1).to(level2)
        end
      end

      context 'with reputation more than level experience' do
        it "levels up from 'First level' to 'Second level'" do
          expect do
            user.update(reputation: 11)
          end.to change { user.reload.level }.from(level1).to(level2)
        end
      end
    end

    describe 'level up bonuses & privileges' do
      let(:user) { CgtraderLevels::User.create!(coins: 1, tax: 20) }

      context 'with one level up' do
        let!(:level2) { CgtraderLevels::Level.create!(experience: 10, title: 'Second level', coins_bonus: 4, tax_reduction: 2) }

        it 'gives level-specific amount of coins to user' do
          expect do
            user.update(reputation: 10)
          end.to change { user.reload.coins }.by(level2.coins_bonus)
        end

        it 'reduces tax rate by level-specific amount of reduction' do
          expect do
            user.update(reputation: 10)
          end.to change { user.reload.tax }.by(-level2.tax_reduction)
        end

        context 'with tax rate 0' do
          let(:user) { CgtraderLevels::User.create!(coins: 1, tax: 0) }

          it 'does not reduce tax rate below zero' do
            expect do
              user.update(reputation: 10)
            end.not_to change { user.reload.tax }
          end
        end
      end

      context 'with two level ups' do
        let!(:level2) { CgtraderLevels::Level.create!(experience: 5, title: 'Second level', coins_bonus: 5, tax_reduction: 1) }
        let!(:level3) { CgtraderLevels::Level.create!(experience: 10, title: 'Third level', coins_bonus: 8, tax_reduction: 4) }

        it 'gives level-specific amount of coins to user' do
          expect do
            user.update(reputation: 10)
          end.to change { user.reload.coins }.by(level2.coins_bonus + level3.coins_bonus)
        end

        it 'reduces tax rate by level-specific amount of reduction' do
          expect do
            user.update(reputation: 10)
          end.to change { user.reload.tax }.by(-(level2.tax_reduction + level3.tax_reduction))
        end
      end
    end
  end

  describe 'existing user' do
    let(:reputation) { 10 }
    let(:user) { CgtraderLevels::User.create!(reputation: reputation) }

    it 'keeps the reputation loaded from database' do
      expect(user.reputation).to eq(10)
    end
  end
end
