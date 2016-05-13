# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Provider.destroy_all
Client.destroy_all
User.destroy_all

provider = Provider.create name: 'Xaver'

client1 = Client.create name: 'Guillermo'
client2 = Client.create name: 'Luciano'

puts "#{Client.count} clients created"

user_admin = User.create! email: 'admin@gmail.com.ar', password: 'secret', role: User::ADMIN
user_provider = provider.users.create! email: 'provider@xaver.com.ar', password: 'secret', role: User::PROVIDER
user_client1 = provider.users.create! email: 'guillermo@gmail.com.ar', password: 'secret', role: User::CLIENT, client: client1
user_client2 = provider.users.create email: 'luciano@gmail.com.ar', password: 'secret', role: User::CLIENT, client: client2

puts "#{User.count} users created"
