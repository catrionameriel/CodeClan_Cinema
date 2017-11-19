class Screening
  attr_reader :film_id, :start_time, :empty_seats

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @film_id = details['film_id'].to_i
    @start_time = details['start_time']
    @empty_seats = details['empty_seats'].to_i
  end






end
