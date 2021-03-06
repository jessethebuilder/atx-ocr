t = Time.now
include FarmShed
# --- Users -----------------------
User.destroy_all

User.create! email: 'test@test.com', admin: true, password: 'password'

#--- Clients ------------------
Client.destroy_all

22.times do
  c = Client.new name: Faker::Name.name,
                 email: Faker::Internet.email,
                 phone: Faker::PhoneNumber.phone_number,
                 company_name: Faker::Company.name,
                 client_number: random_password,
                 keywords: Faker::Lorem.words.join(',')

  # if(Random.rand(1..5) == 1)
  c.keywords << %w|paypal national food|.sample
  # end

  c.save!
end

c = Client.new name: Faker::Name.name,
               email: 'jessethebuilder@yahoo.com',
               phone: Faker::PhoneNumber.phone_number,
               company_name: Faker::Company.name,
               client_number: random_password,
               keywords: Faker::Lorem.words.join(',')

# if(Random.rand(1..5) == 1)
c.keywords << %w|paypal national food|.sample
# end

c.save!


#--- Mail Queues -----------------------------------------

MailQueue.destroy_all

n = Time.now

puts (n - t)
