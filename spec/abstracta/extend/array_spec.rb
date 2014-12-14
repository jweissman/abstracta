require 'spec_helper'
require 'active_support/core_ext/array'
require 'abstracta/extend/array'

describe Array do
  subject do 
    [1,2,3,0]
  end

  it 'should decode straightforwardly as a geometric coordinate' do
    expect(subject.x).to eql(1)
    expect(subject.y).to eql(2)
    expect(subject.z).to eql(3)
    expect(subject.t).to eql(0)
  end

  it 'should process in parallel' do
    expect(subject).to respond_to(:parallel_each)
    expect { subject.parallel_each(&method(:print)) }.to_not raise_error
  end
end
