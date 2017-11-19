require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(details)
    @id = details['id'].to_i if details ['id']
    @name = details['name']
    @funds = details['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers(
    name,
    funds
    )
    VALUES(
    $1,
    $2
    )
    RETURNING *"
    values = [@name, @funds]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers
    SET (name, funds)
    = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    customer = Customer.new(result[0])
    return customer
  end

  def self.all
    sql = "SELECT * FROM customers"
    result = SqlRunner.run(sql)
    return result.map {|customer| Customer.new(customer)}
  end

  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE tickets.customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    films = result.map{ |film| Film.new(film) }
    return films
  end

  def how_many_tickets()
    sql = "SELECT * from tickets WHERE customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    tickets = result.map{ |ticket| Ticket.new(ticket)}
    return tickets.count
  end
  # How could I split this into two methods?
  # Should this be in tickets?


end
