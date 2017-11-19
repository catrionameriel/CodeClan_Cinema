require_relative('../db/sql_runner')

class Ticket

  attr_reader :id, :customer_id, :film_id


  def initialize(details)
    @id = details['id'].to_i if details['id']
    @customer_id = details['customer_id'].to_i
    @film_id = details['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets(
    customer_id,
    film_id
    )
    VALUES(
    $1,
    $2
    )
    RETURNING *"
    values = [@customer_id, @film_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id']
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    ticket = Ticket.new(result[0])
  end

  def self.all
    sql = "SELECT * FROM tickets"
    result = SqlRunner.run(sql)
    return result.map{ |ticket| Ticket.new(ticket)}
  end

  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    result = SqlRunner.run(sql, values)
    return Film.new(result[0])
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    result = SqlRunner.run(sql, values)
    return Customer.new(result[0])
  end

end
