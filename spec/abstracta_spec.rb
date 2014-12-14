require 'spec_helper'
require 'abstracta'
include Abstracta

describe Abstracta do
  describe "constants" do
    let(:version) { subject.const_get 'VERSION' }
    it "should have a VERSION constant" do
      expect(version).not_to be_empty
    end
  end
end
