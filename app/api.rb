require 'grape'

module App
  class API < Grape::API
    version 'v1'
    format :json
    prefix :api

    resource :movies do
      desc 'Creates a new movie.'
      params do
        requires :name, type: String
        requires :description, type: String
        requires :days, type: String
      end

      post do
        movie = CreateMovie.new.call(Movie.new(params))

        if movie.success?
          movie.success.values
        else
          error!(movie.failure.values, 422)
        end
      end

      desc 'Returns a list of movies given a day.'
      params do
        requires :day, type: String
      end

      get do
        movies = ListMovie.new.call(params[:day])

        if movies.success?
          movies.success.map &:values
        else
          error!(movies.failure.values, 422)
        end
      end
    end

    resource :reservations do
      desc 'Creates a new reservation.'

      post do
        reservation = CreateReservation.new.call(Reservation.new(params))

        if reservation.success?
          reservation.success.values
        else
          error!(reservation.failure.values, 422)
        end
      end

      desc 'Returns a list of reservations given a date range.'
      params do
        requires :start_date, type: String, desc: 'Start date'
        requires :end_date, type: String, desc: 'End date'
      end

      get do
        reservations = ListReservation.new.call(params)

        if reservations.success?
          reservations.success.map &:values
        else
          error!(reservations.failure.values, 422)
        end
      end
    end
  end
end
