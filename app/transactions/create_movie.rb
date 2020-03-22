require 'dry-transaction'

class CreateMovie
  include Dry::Transaction

  step :validate
  step :persist

  def validate(data)
    movie = Movie.new(name: data[:name], description: data[:description], image_url: data[:image_url], days: data[:days])
    if movie.valid?
      Success(movie)
    else
      Failure(errors: movie.errors)
    end
  end

  def persist(name:, description:, image_url:, days:)
    movie = Movie.create(name: name, description: description, image_url: image_url, days: days)
    Success(movie)
  end
end