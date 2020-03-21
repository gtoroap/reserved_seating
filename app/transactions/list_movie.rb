require 'dry-transaction'

class ListMovie
  include Dry::Transaction

  step :list

  def list(day)
    if Movie::DAYS.include?(day)
      movies = Movie.where(days: Regexp.new(day)).all
      Success(movies)
    else
      Failure(error: 'Day does not have a valid format')
    end
  end

end