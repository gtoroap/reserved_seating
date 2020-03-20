require 'grape'
module App
  class API < Grape::API
    version 'v1'
    format :json
    prefix :api

    resource :movies do
      desc 'Creates a new movie.'
      post do
        #Creates a new movies
      end

      desc 'Returns a list of movies given a day.'
      params do
        requires :day, type: String, desc: 'Day of week'
      end
      get do
        #Returns a list of movies given a day
      end
    end

    resource :reservations do
      desc 'Creates a new reservation.'
      post do
        #Creates a new reservation
      end

      desc 'Returns a list of reservations given a date range.'
      params do
        requires :start_date, type: String, desc: 'Start date'
        requires :end_date, type: String, desc: 'End date'
      end
      get do
        #Returns a list of reservations given a date range
      end
    end
  end
end
