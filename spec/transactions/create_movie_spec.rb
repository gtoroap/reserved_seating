describe CreateMovie, type: :transaction do
  subject { described_class.new.call(params) }

  let(:params) do
    {
      name: 'Joker',
      description: 'Joker',
      days: 'mon,thu',
      image_url: nil
    }
  end

  context 'a new movie is created with valid params' do
    it { is_expected.to be_success }

    it 'creates a new movie' do
      expect { subject }.to(change { Movie.count }.by(1))
    end

    it 'return a new movie' do
      expect(subject.success).to be_a(Movie)
    end
  end

  context 'a new movie is created with invalid params' do
    let(:params) do
      {
        name: nil,
        description: nil,
        days: 'jan,feb',
        image_url: nil
      }
    end

    it { is_expected.to be_failure }

    it 'returns an error hash' do
      expect(subject.failure).to be_a(Hash)
    end
  end
end