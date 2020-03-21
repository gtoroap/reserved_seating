class CreateReservations
  Sequel.migration do
    change do
      create_table(:reservations) do
        primary_key :id
        Integer :movie_id, null: false
        String :date, null: false
        String :client_fullname
        String :total_seats
      end
    end
  end
end