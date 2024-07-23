require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    before do
      @user = FactoryBot.build :user
    end

    it 'is valid when all attributes are present' do
      expect(@user.valid?).to eq true
    end

    # devise adds validation for email but we're testing it anyway for clarity
    context 'given that the username attribute is missing' do
      before do
        @user.username = nil
      end

      it 'is invalid' do
        expect(@user.valid?).to eq false
      end

      it 'has expected error message' do
        expected = [ "can't be blank" ]
        @user.valid?
        expect(@user.errors[:username].to_a).to eq expected
      end
    end

    # devise adds validation for email but we're testing it anyway for clarity
    context 'given that the email attribute is missing' do
      before do
        @user.email = nil
      end

      it 'is invalid' do
        expect(@user.valid?).to eq false
      end

      it 'has expected error message' do
        expected = [ "can't be blank" ]
        @user.valid?
        expect(@user.errors[:email].to_a).to eq expected
      end
    end

    # devise adds validation for password but we're testing it anyway for clarity
    context 'given that the password attribute is missing' do
      before do
        @user.password = nil
      end

      it 'is invalid' do
        expect(@user.valid?).to eq false
      end

      it 'has expected error message' do
        expected = [ "can't be blank" ]
        @user.valid?
        expect(@user.errors[:password].to_a).to eq expected
      end
    end
  end
end
