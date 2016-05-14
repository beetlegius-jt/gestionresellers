# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Order.destroy_all
Product.destroy_all
Client.destroy_all
Provider.destroy_all

provider = Provider.create name: 'Xaver'

60.times { FactoryGirl.create (rand(1).zero? ? :product : :package_product), provider: provider }

puts "#{Product.count} products created"

client1 = Client.create name: 'Guillermo'
client2 = Client.create name: 'Luciano'

puts "#{Client.count} clients created"

for client in Client.all
  3.times do
    order = FactoryGirl.create(:order, client: client, provider: provider)
    rand(1..4).times do
      FactoryGirl.create(:item, order: order)
    end
  end
end

puts "#{Order.count} orders created with #{Item.count} items"

user_admin = User.create! email: 'admin@gmail.com', password: 'secret', role: User::ADMIN
user_provider = provider.users.create! email: 'provider@xaver.com.ar', password: 'secret', role: User::PROVIDER
user_client1 = provider.users.create! email: 'guillermo@gmail.com', password: 'secret', role: User::CLIENT, client: client1
user_client2 = provider.users.create email: 'luciano@gmail.com', password: 'secret', role: User::CLIENT, client: client2

puts "#{User.count} users created"
