require_relative('../db/sql_runner')

class Ticket

  attr_reader :id, :customer_id, :film_id


  def initialize(details)
    @id = details['id'].to_i if details['id']
    @customer_id = details['customer_id'].to_i
    @film_id =
  end

  def save

  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
