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

  def self.all()
    sql = "SELECT * FROM screenings"
    result = SqlRunner.run(sql)
    return result.map { |screening| Screening.new(screening) }
  end

  def update()
    sql = "UPDATE screenings SET(
      start_time,
      empty_seats
      )
      = ($1, $2)
      WHERE id = $3"
      values = [@start_time, @empty_seats, @id]
      SqlRunner.run(sql, values)
  end

  def film
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    film = SqlRunner.run(sql,values)[0]
    return film
  end

  # def self.most_popular()
  #   sql = "SELECT * FROM screenings ORDER BY empty_seats ASC"
  #   result = SqlRunner.run(sql)
  #   ordered_screenings = result.map { |screening| Screening.new(screening) }
  #   return ordered_screenings[0]
  # end
  # <----- Still like this method!

  def customer_buys_ticket
    @empty_seats -= 1
    sql = "UPDATE screenings
    SET empty_seats = $1 WHERE id = $2"
    values = [@empty_seats, @id]
    SqlRunner.run(sql, values)
  end

  # def self.most_popular
  #   sql = "SELECT * from tickets ORDER BY $1 ASC"
  #   values = [@film_id]
  #   result = SqlRunner.run(sql, values)
  #   tickets_bought = result.map {|ticket| Ticket.new(ticket)}
  # end

  def self.most_popular
    sql = "SELECT film_id, COUNT(*) FROM tickets GROUP BY film_id ORDER BY COUNT DESC"
    number_of_tickets_per_screening = SqlRunner.run(sql)
    return number_of_tickets_per_screening[0]
  end
  # Comes back as hash - how to not have hash?



end
