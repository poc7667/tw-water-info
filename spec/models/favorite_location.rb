describe 'FavoriteLocation' do

  before do
    class << self
      include CDQ
    end
    cdq.setup
  end

  after do
    cdq.reset!
  end

  it 'should be a FavoriteLocation entity' do
    FavoriteLocation.entity_description.name.should == 'FavoriteLocation'
  end
end
