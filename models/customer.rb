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

end
