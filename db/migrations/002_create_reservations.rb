class CreateReservations
  Sequel.migration do
    change do
      create_table(:reservations) do
        primary_key :id
        String :date, null: false
        String :client_fullname
        String :total_seats
        foreign_key :movie_id, :movies
      end
    end
  end
end