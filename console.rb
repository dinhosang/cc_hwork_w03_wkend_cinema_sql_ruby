require('pry-byebug')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')


Ticket.delete_all()
Film.delete_all()
Customer.delete_all()


customer1 = Customer.new({"name" => 'Jasmine', "funds" => 300})
customer1.save()
customer2 = Customer.new({'name' => 'James', 'funds' => 200})
customer2.save()

film1 = Film.new({'title' => 'Zoro the real movie', 'price' => 15, 'times' => ['09:00:00', '12:00:00']})
film1.save()
film2 = Film.new({'title' => 'Pokemon the Movie', 'price' => 30, 'times' => ['11:00:00', '14:00:00']})
film2.save()
film3 = Film.new({'title' => 'Digimon', 'price' => 200, 'times' => ['18:00:00']})
film3.save()


customer1.funds = 233
customer2.name = 'Jam'


ticket5 = customer1.purchase_ticket(film3, '1800')
ticket6 = customer1.purchase_ticket(film3, '1800')

customer2.funds = 1000

ticket7 = customer2.purchase_ticket(film3, '1800')
ticket8 = customer2.purchase_ticket(film2, '1400')
ticket8 = customer2.purchase_ticket(film2, '1400')
ticket9 = customer2.purchase_ticket(film2, '1100')
ticket10 = customer2.purchase_ticket(film2, '1100')
ticket11 = customer2.purchase_ticket(film1, '0900')

blah = film2.busiest_time
binding.pry

film2.price = 30
film1.title = 'Zorro'

ticket3.customer_id = customer1.id

customer1.update()
customer2.update()
film2.update()
film1.update()
ticket3.update()


binding.pry


customer2.delete()
film1.delete()
ticket3.delete()


binding.pry
nil
