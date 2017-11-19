require_relative('../db/sql_runner')

class Screening
  attr_reader :film_id
  attr_accessor :start_time, :empty_seats

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @film_id = details['film_id'].to_i
    @start_time = details['start_time']
    @empty_seats = details['empty_seats'].to_i
  end

  def save
    sql = "INSERT INTO screenings(
      film_id,
      start_time,
      empty_seats
    )
    VALUES(
      $1, $2, $3
      )
      RETURNING *"
      values = [@film_id, @start_time, @empty_seats]
      result = SqlRunner.run(sql, values)
      @id = result[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM screenings"
    result = SqlRunner.run(sql)
    return result.map { |screening| Screening.new(screening)}
  end

  def update
    sql = "UPDATE screenings SET(
      start_time,
      empty_seats
      )
      = ($1, $2)
      WHERE id = $3"
      values = [@start_time, @empty_seats, @id]
      SqlRunner.run(sql, values)
  end

  def most_popular
    

  end





end
