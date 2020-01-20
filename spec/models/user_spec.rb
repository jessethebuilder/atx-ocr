require 'rails_helper'

describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe 'Validations' do
    it{ should validate_presence_of :email }
    it{ should validate_presence_of :password }
  end

  describe 'Associations' do
    it{ should have_one :client }
  end

  describe 'Methods' do
  end # Methods

  describe 'Scopes' do
    before(:each) do
      @user.save!
      @admin = create(:admin)
    end

    describe 'Admins' do
      it 'should return admins' do
        User.admins.should == [@admin]
      end
    end
  end
end
