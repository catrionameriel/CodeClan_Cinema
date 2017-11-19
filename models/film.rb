require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price


  def initialize(details)
    @id = details['id'].to_i if details['id']
    @title = details['title']
    @price = details['price'].to_i
  end

  def save()
    sql = "INSERT INTO films(
    title,
    price
    )
    VALUES(
    $1,
    $2
    )
    RETURNING *"
    values = [@title, @price]
    result = SqlRunner.run(sql,values)
    @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE films SET
    (title, price)
    = ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    film = Film.new(result[0])
    return film
  end

  def self.all
    sql = "SELECT * FROM films"
    result = SqlRunner.run(sql)
    return result.map { |film| Film.new(film) }
  end

  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    customers = result.map{ |customer| Customer.new(customer) }
    return customers
  end



end
