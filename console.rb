require('pry-byebug')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')


customer1 = Customer.new({"name" => 'Jasmine', "funds" => 300})
customer1.save()
customer2 = Customer.new({'name' => 'James', 'funds' => 200})
customer2.save()

film1 = Film.new({'title' => 'Zoro the real movie', 'price' => 15})
film1.save()
film2 = Film.new({'title' => 'Pokemon the Movie', 'price' => 30})
film2.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save
ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket3.save


binding.pry


customer1.funds = 233
customer2.name = 'Jam'

film2.price = 30
film1.title = 'Zorro'

ticket3.customer_id = customer1.id

customer1.update()
customer2.update()
film2.update()
film1.update()
ticket3.update()


binding.pry
nil
