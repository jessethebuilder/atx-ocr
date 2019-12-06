require 'rails_helper'

RSpec.describe MailImageRequest, type: :model do
  let(:mail_image_request){ build :mail_image_request }

  describe 'Validations' do
    it{ should validate_presence_of :type }
    it{ should validate_inclusion_of(:type).to_allow(MailImageRequest::TYPES) }
    it{ should validate_presence_of :client }
    it{ should validate_presence_of :mail_image }

    it 'should not validate if of type "forward" and shipping_company is nil' do
      mail_image_request.type = 'forward'
      mail_image_request.shipping_company = nil
      mail_image_request.valid?.should == false
      mail_image_request.errors[:shipping_company].include?('cannot be blank if type is "Forward"').should == true
    end

    it 'should not validate if complete AND type == "forward" AND tracking_id == nil' do
      mail_image_request.type = 'forward'
      mail_image_request.complete = true
      mail_image_request.valid?.should == false
      mail_image_request.errors[:tracking_id].include?('cannot be blank if type is "Forward"').should == true
    end
  end

  describe 'Associaions' do
    it{ should belong_to :client }
    it{ should belong_to :mail_image }
  end

  describe 'Idioms' do
    describe "Complete" do
      specify '#complete should default as false' do
        mail_image_request.complete.should == false
      end

      specify '#completed_at should be set when saved as "complete"' do
        mail_image_request.completed_at.should == nil
        mail_image_request.update_attribute(:complete, true)
        mail_image_request.completed_at.should_not == nil
      end

      specify "#completed_at should be set to nil when saved when #complete == false" do
        mail_image_request.update_attribute(:complete, true)
        mail_image_request.completed_at.should_not == nil
        mail_image_request.update_attribute(:complete, false)
        mail_image_request.completed_at.should == nil
      end
    end
  end # Idioms

  describe 'Scopes' do
    describe 'compelete' do
      specify ':complete should only return complete mail_image_requests' do
        mail_image_request.save!
        complete_mail_image_request = create(:completed_mail_image_request)
        MailImageRequest.complete.count.should == 1
        MailImageRequest.complete.first.should == complete_mail_image_request
      end
    end
  end
end
