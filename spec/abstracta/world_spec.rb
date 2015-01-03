require 'spec_helper'
require 'abstracta'

include Abstracta

describe World do
  let(:w)   { 50 }
  let(:h)   { 50 }
  let(:geometry) { [w,h] }

  subject { World.new(dimensions: geometry, territory_count: 1) }

  let!(:territory) { subject.territories.first }

  it 'should have an age' do
    expect(subject.age).to be_zero
  end

  it 'should generate a territory' do
    expect(territory).to be_a(Territory)
    expect(territory.size).to be > 1
  end

  it 'should indicate what spaces are available' do
    expect(subject.occupied.size).to be > 1
  end

  context "territory creation" do
    context "with a given density" do
      let(:density) { 0.00125 }
      let(:projected_count) { (w * h * density).to_i }

      subject { World.new(dimensions: geometry, density: density) }
      let(:actual_territory_count) { subject.territories.count }

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

      it "should generate territories with Integer-valued positions" do
	expect(territory.first.x).to be_an(Integer)
	expect(territory.first.y).to be_an(Integer)
      end
    end

    context "with a specified count" do
      N = 15
      subject { World.new(dimensions: geometry, territory_count: N) }
      it "should have #{N} territories" do
	expect(subject.territories.count).to eql(N)
	expect(territory).to be_a(Territory)
      end

    end
  end

  context "#step" do
    it 'should age the world' do
      expect { subject.step }.to change { subject.age }.by 1
    end

    it 'should grow the world' do
      expect { subject.step }.to change { subject.size }.by(a_value > 0)
      #expect { subject.step }.to change { subject.size }.by(a_value <= (subject.projected_growth.to_i))
    end

    context "growth behaviors" do
      let(:n) { 10 }

      before do
        n.times { subject.step }
      end

      it 'should grow a bit' do
	expect(subject.size).to be > 3
      end

      it 'should not have grown outside the global boundary' do
        within_bounds = subject.occupied.all? { |p| subject.include?(p) }
        expect(within_bounds).to be(true)
      end
    end
  end
end
