require 'rails_helper'

describe 'Client Features', type: :feature do
  before do
    sign_in_admin

    @client_attributes = attributes_for(:client)
  end

  describe 'Creating a Client' do
    def client_min
      visit '/clients/new'
      fill_in 'Email', with: @client_attributes[:email]
      fill_in 'Name', with: @client_attributes[:name]
      fill_in 'Keywords', with: @client_attributes[:keywords].join(',')
    end

    it 'should crate a client' do
      client_min
      expect{ click_button 'Create Client' }.to change{ Client.count }.by(1)
    end

    it 'should have required attribute' do
      client_min
      click_button 'Create Client'

      client = Client.last
      client.email.should == @client_attributes[:email]
      client.name.should == @client_attributes[:name]
      client.keywords.should == @client_attributes[:keywords]
    end

    it 'should save :phone' do
      phone = Faker::PhoneNumber.phone_number
      client_min
      fill_in 'Phone', with: phone
      click_button 'Create Client'
      Client.last.phone.should == phone
    end

    it 'should save :company_name' do
      company_name = Faker::Company.name
      client_min
      fill_in 'Company name', with: company_name
      click_button 'Create Client'
      Client.last.company_name.should == company_name
    end

    it 'should save :client_number' do
      client_number = Random.rand(10000.1000000).to_s
      client_min
      fill_in 'Client number', with: client_number
      click_button 'Create Client'
      Client.last.client_number.should == client_number
    end

    it 'should save :email2' do
      email2 = Faker::Internet.email
      client_min
      fill_in 'Email2', with: email2
      click_button 'Create Client'
      Client.last.email2.should == email2
    end

    it 'should save :email3' do
      email3 = Faker::Internet.email
      client_min
      fill_in 'Email3', with: email3
      click_button 'Create Client'
      Client.last.email3.should == email3
    end
  end
end
