require 'rails_helper'

RSpec.describe NotificationsMailer, type: :mailer do
  describe 'business creation' do
    let(:mail) {
      NotificationsMailer.contact(
        name: "Imagine Photography",
        email: "tyler@tyler.com",
        message: "Hello!"
      )
    }

    it 'renders the subject' do
      expect(mail.subject).to eql('Message from Imagine Photography')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql(['tyler@tyler.com'])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['admin@imagine-photography.com'])
    end
  end
end
