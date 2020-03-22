require 'dry-transaction'

class CreateReservation
  include Dry::Transaction

  step :validate
  step :persist

  def validate(data)
    if data.valid?
      Success(movie_id: data.movie_id, date: data.date, client_fullname: data.client_fullname, seats: data.seats)
    else
      Failure(errors: data.errors)
    end
  end

  def persist(movie_id:, date:, client_fullname:, seats:)
    movie = Movie.get(movie_id)
    reservation = movie.add_reservation(date: date, client_fullname: client_fullname, seats: seats)
    Success(reservation)
  end
end