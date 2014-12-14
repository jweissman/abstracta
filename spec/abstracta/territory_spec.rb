require 'spec_helper'
require 'abstracta'
include Abstracta

describe Territory do
  subject { Territory.new(occupants) } #w(double(:available? => true)) }
  context "#step" do
    let(:occupants) { [occupant] }
    let(:occupant)  { Occupant.new } # OpenStruct.new(age: 0, x: 0, y: 0) } #subject.occupants.first }

    it "should age occupants" do
      expect { subject.step }.to change { occupant.age }.by 1
    end

    it "should grow total size" do
      expect { subject.step }.to change { subject.size }.by(1)
    end

    #it "should be safe to repeat several times" do
    #  expect { 10.times { subject.step }}.not_to raise_error
    #end
  end
end

