require('pry-byebug')
require_relative('models/ticket')
require_relative('models/customer')
require_relative('models/film')
# require_relative('models/screening')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({'name' => 'Keith', 'funds' => 250.00})
customer1.save()
customer2 = Customer.new({'name' => 'Sandy', 'funds' => 200.00})
customer2.save()
customer3 = Customer.new({'name' => 'Craig', 'funds' => 50.00})
customer3.save()
customer4 = Customer.new({'name' => 'Zsolt', 'funds' => 50.00})
customer4.save()

customer4.delete()

film1 = Film.new({'title' => 'Memento', 'price' => 10.00 })
film1.save
film2 = Film.new({'title' => 'Inception', 'price' => 9.00 })
film2.save
film3 = Film.new({'title' => '22 Jump Street', 'price' => 11.00 })
film3.save
film4 = Film.new({'title' => 'Sausage Party', 'price' => 12.00})
film4.save

film4.delete

customer3.name = 'Sian'
customer3.update

film3.price = 9
film3.update

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket1.save

# Screening.most_popular should return screening2
binding.pry
nil
