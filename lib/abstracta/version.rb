module Abstracta
  VERSION   = "0.1.0"
  RELEASE   = "prealpha"
  CRYPTONYM = "aqua-prism"
  AUTHOR    = "Joseph Weissman <jweissman1986@gmail.com>"

  def self.version
    "v#{VERSION}-#{RELEASE} \"#{CRYPTONYM}\", (c) #{Date.today.year} #{AUTHOR}"
  end
end
