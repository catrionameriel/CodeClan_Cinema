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

end
