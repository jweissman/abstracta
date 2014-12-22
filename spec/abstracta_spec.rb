require 'spec_helper'
require 'abstracta'
include Abstracta

describe Abstracta do
  describe "constants" do
    it "should have a VERSION constant" do
      expect(subject.version).to eql("v0.1.0-prealpha \"aqua-prism\", (c) 2014 Joseph Weissman <jweissman1986@gmail.com>")
    end
  end
end
