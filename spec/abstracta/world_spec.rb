require 'spec_helper'
require 'abstracta'

include Abstracta

describe World do
  let(:width)   { 10 }
  let(:height)  { 10 }

  subject { World.new(width: width, height: height) }

  #let!(:field) { subject.field }
  let!(:territory) { subject.territories.first }
  let!(:occupant) { subject.occupants.first }

  it 'should have an age' do
    expect(subject.age).to be_zero
  end

  it 'should generate a territory' do
    expect(territory).to be_a(Territory)
  end

  #it "should construct a field" do
  #  expect(field.any?).to eql(true) 
  #  expect(field.width).to eql(width)
  #  expect(field.height).to eql(height)
  #end

  context "territory creation" do
    context "with a given density" do
      let(:density) { 0.3 }
      let(:projected_count) { (width * height * density).to_i }
      subject { World.new(width: width, height: height, density: density) }
      let!(:actual_territory_count) { subject.territories.count }

      it "should have territories" do
	expect(subject.territories).not_to be_empty
      end

      it "should have the projected number of territories" do
	expect(actual_territory_count).to eql(projected_count) #width*height*density)
      end

      it "should generate Territory objects with nonzero size" do
	expect(territory).to be_a(Territory)
	expect(territory.size).to be > 0
      end
    end

    context "with a specified count" do
      subject { World.new(width: width, height: height, territory_count: 3) }
      it "shoud have 3 territories" do
	expect(subject.territories.count).to eql(3)
	expect(territory).to be_a(Territory)
      end
    end
  end

  it "should be occupied" do 
    expect(subject.occupants).not_to be_empty
    expect(occupant).to be_a(Occupant)
  end

  context "#step" do
    it 'should age the world' do
      expect { subject.step }.to change { subject.age }.by(1)
    end

    it "should expand the territories" do
      expect { subject.step }.to change { territory.size }.by(1)
    end

    #it "should step safely for awhile" do
    #  expect { 1000.times { subject.step }}.to_not raise_error
    #end
  end
end
