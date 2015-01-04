require 'spec_helper'
require 'abstracta'

describe Abstracta::Oracle do
  let(:pop) {{[0,0]=>1, [0,1]=>0.5}}
  
  before do
    @remarks, @prediction = subject.predict(pop)
  end

  it 'should compute local neighborhood' do
    expect(subject.neighbors([0,0], pop)).to eql([0.5])
  end

  it 'should predict colors' do
    expect(@remarks).to eql("Population changed by 2")
    expect(@prediction.size).to eql(4)
    expect(@prediction[[1,1]]).to eql(0.75)
  end
end
