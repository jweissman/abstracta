require 'spec_helper'
require 'abstracta'

describe Abstracta::Oracle do
  let(:pop) {{[0,0]=>1, [0,1]=>1}}

  it 'should predict colors' do
    expect(pop.size).to eql(2)
    remarks, prediction = subject.predict(pop)
    expect(remarks).to eql("Population changed by 2")
    expect(prediction.size).to eql(4)
  end
end
