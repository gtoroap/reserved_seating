describe CreateReservation, type: :transaction do

  before(:each) do
    @movie = Movie.create(name: 'Dummy', description: 'Dummy', image_url: nil, days: 'mon,tue')
  end

  subject { described_class.new.call(params) }

  let(:params) do
    {
      movie_id: @movie.id,
      date: '2020-03-23',
      client_fullname: 'John Doe',
      seats: 2
    }
  end

  context 'a new reservation is created with valid params' do
    it { is_expected.to be_success }

    it 'creates a new reservation' do
      expect { subject }.to(change { Reservation.count }.by(1))
    end

    it 'return a new reservation' do
      expect(subject.success).to be_a(Reservation)
    end
  end

  context 'a new reservation is created with invalid params' do
    let(:params) do
      {
        movie_id: nil,
        date: '2020-03-222',
        seats: 0
      }
    end

    it { is_expected.to be_failure }

    it 'returns an error hash' do
      expect(subject.failure).to be_a(Hash)
    end
  end
end