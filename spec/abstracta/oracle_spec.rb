require 'spec_helper'
require 'abstracta'

describe Abstracta::Oracle do
  let(:pop) {{[0,0]=>0xEFEFEFEF, [0,1]=>0x0A0A0A0A}}
  
  before do
    @births, @deaths, @prediction = subject.predict(pop)
  end

  it 'should compute local neighborhood' do
    expect(subject.neighbors([0,0], pop)).to eql([168430090])
  end

  it 'should predict colors' do
    expect(@births).to eql(4)
    expect(@deaths).to eql(0)
    expect(@prediction.size).to eql(6)
    expect(@prediction[[1,1]]).to eql(137451771526020)
  end
end
