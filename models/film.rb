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

end
