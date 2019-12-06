require 'rails_helper'

describe Client, type: :model do
  before do
    @client = build(:client)
  end

  describe 'Validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :email }
    it{ should validate_uniqueness_of :email }
    it{ should validate_presence_of :keywords }
  end

  describe 'Associations' do
    it{ should have_many(:client_keyword_matches) }
    it{ should have_many(:mail_image_requests) }
    it{ should belong_to(:user) }
    it{ should have_many(:mail_queues) }

    describe 'Dependencies' do
      describe 'MailImageRequests' do
        it 'should delete MailImageRequests on destroy' do
          mail_image_request = create(:mail_image_request)
          mail_image_request.client.destroy
          mail_image_request.persisted?.should == false
        end

        it 'should delete even if mail_image_request is marked as "complete"' do
          mail_image_request = create(:completed_mail_image_request)
          mail_image_request.client.destroy
          mail_image_request.persisted?.should == false
        end
      end

      it 'should delete ClientKeywordMatches on destroy' do
        client_keyword_match = create(:client_keyword_match)
        client_keyword_match.client.destroy
        client_keyword_match.persisted?.should == false
      end
    end
  end

  describe 'Methods' do
    describe '#display_keywords' do
      it 'should return a comma delinimated list of the keywords' do
        @client.keywords = %w|have a nice day|
        @client.display_keywords.should == 'have, a, nice, day'
      end
    end

    describe '#emails' do
      it 'should return an array with :email in it by default' do
        @client.emails.should == [@client.email]
      end

      it 'should add email2 to the array if it exists' do
        @client.email2 = Faker::Internet.email
        @client.emails.should == [@client.email, @client.email2]
      end

      it 'should add email3 to the array if it exists' do
        @client.email3 = Faker::Internet.email
        @client.emails.should == [@client.email, @client.email3]  
      end
    end

    describe '#keywords=' do
      it 'expects a string, deliniated by commas, which it sets as :keywords (array)' do
        @client.keywords = 'have, a, nice, day'
        @client.keywords.should == %w|have a nice day|
      end

      it 'does not care if there is a space after the comma' do
        @client.keywords = 'have,a, nice,day'
        @client.keywords.should == %w|have a nice day|
      end

      it 'also accepts an array' do
        @client.keywords = %w|have a nice day|
        @client.keywords.should == %w|have a nice day|
      end
    end # keywords=

    describe '#mail_images' do
      it 'should return MailImages for the client via ClientKeywordMatches' do
        client_keyword_match = create(:client_keyword_match)
        client_keyword_match.client.mail_images.should == [client_keyword_match.mail_image]
      end
    end

    describe '#send_email' do
      #jfx PENDING!!!!
    end

  end # Methods

  describe "Idioms" do
    describe "The Client's User" do
      # The User is added to give Client Devise capiblities.
      it "should save a User on creation" do
        expect{ @client.save }.to change{ User.count }.by(1)
      end

      it "should update a User's email after save" do
        @client.email = "anew@email.com"
        @client.save
        @client.user.email.should == "anew@email.com"
      end
    end
  end # Idioms
end
