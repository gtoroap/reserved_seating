describe ListMovie, type: :transaction do
  before(:each) do
    Movie.create(name: 'Dummy', description: 'Dummy', image_url: nil, days: 'mon,tue')
  end

  subject { described_class.new.call(params[:day]) }

  let(:params) { {day: 'mon'} }

  context 'a list of movies is returned with valid params' do
    it { is_expected.to be_success }

    it 'return a list of movies' do
      expect(subject.success).to be_a(Array)
    end
  end

  context 'a list of movies is not returned with invalid params' do
    let(:params) do
      {
        day: 'jan'
      }
    end

    it { is_expected.to be_failure }

    it 'returns an error hash' do
      expect(subject.failure).to be_a(Hash)
    end
  end
end