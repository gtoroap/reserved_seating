describe ListReservation, type: :transaction do
  before(:each) do
    @movie = Movie.create(name: 'Dummy', description: 'Dummy', image_url: nil, days: 'mon,tue')
    Reservation.create(movie_id: @movie.id, date: '2020-03-23', client_fullname: 'John Doe', seats: 2)
  end

  subject { described_class.new.call(params) }

  let(:params) { {start_date: '2020-03-20', end_date: '2020-03-25'} }

  context 'a list of reservations is returned with valid params' do
    it { is_expected.to be_success }

    it 'return a list of reservations' do
      expect(subject.success).to be_a(Array)
    end
  end

  context 'a list of reservations is not returned with invalid params' do
    let(:params) { {start_date: '2020-03-29', end_date: '2020-03-25'} }

    it { is_expected.to be_failure }

    it 'returns an error hash' do
      expect(subject.failure).to be_a(Hash)
    end
  end
end