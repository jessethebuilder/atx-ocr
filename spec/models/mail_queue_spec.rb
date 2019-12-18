require 'rails_helper'

describe MailQueue, type: :model do
  before do
    @mail_queue = build :mail_queue

    allow_any_instance_of(ImageMailer).to receive(:open){ double(read: nil) }
  end

  describe 'Validations' do
  end

  describe 'Associations' do
    it{ should have_many :mail_images }
  end

  describe 'Attributes' do
    specify '#complete should default to false' do
      @mail_queue.complete.should == false
    end

    specify '#marked_for_completion should default to false' do
      @mail_queue.marked_for_completion.should == false
    end
  end # Associations

  describe 'Methods' do
    before do
      @client = create(:client)
      @mail_image = create(:mail_image, mail_queue: @mail_queue)
      @client_keyword_match = create(:client_keyword_match, mail_image: @mail_image, client: @client)
    end

    describe '#mail_images_for(client)' do

      it 'should return an array of images for this Client on this MailQueue' do
        @mail_queue.mail_images_for(@client).should == [@mail_image]
      end
    end

    describe '#cilents' do
      it 'should return all Clients that have a client_keyword_match wiht any MailImage' do
        @mail_queue.clients.should == [@client]
      end
    end

    describe '#send_emails' do
      it 'should set #complete to true when complete' do
        expect{ @mail_queue.send_emails }
              .to change{ @mail_queue.complete }
              .from(false).to(true)
      end

      it 'should return the number of emails sent (which is the same as the
          number of clients that match)' do
        @mail_queue.send_emails.should == 1
      end
    end

    describe '#name' do
      it 'exists' do
        @mail_queue.save!
        @mail_queue.name.should_not == nil
      end
    end

  end # Methods

  describe 'Scopes' do
    before(:each) do
      @mail_queue.save!
    end

    describe '#complete' do
      it 'should return only complete MailQueues' do
        complete_mail_queue = create(:mail_queue, complete: true)
        MailQueue.complete.count.should == 1
        MailQueue.complete.first.should == complete_mail_queue
      end
    end

    describe '#incomplete' do
      it 'should return only incomplete MailQueues' do
        complete_mail_queue = create(:mail_queue, complete: true)
        MailQueue.complete.count.should == 1
        MailQueue.incomplete.first.should == @mail_queue
      end
    end

    describe '#marked_for_completion' do
      it 'should return MailQueues marked_for_completion, if they are incomplete' do
        complete_mail_queue = create(:mail_queue, complete: true, marked_for_completion: true)
        incomplete_mail_queue = create(:mail_queue, marked_for_completion: true)
        MailQueue.complete.count.should == 1
        MailQueue.marked_for_completion.should == [incomplete_mail_queue]
      end
    end
  end # Scopes
end
