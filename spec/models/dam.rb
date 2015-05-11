describe 'Dam' do

  before do
    class << self
      include CDQ
    end
    cdq.setup
  end

  after do
    cdq.reset!
  end

  it 'should be a Dam entity' do
    Dam.entity_description.name.should == 'Dam'
  end
end
