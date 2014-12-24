module Abstracta
  VERSION   = "0.1.1"
  RELEASE   = "prealpha"
  CRYPTONYM = "turquoise-polygon"
  AUTHOR    = "Joseph Weissman <jweissman1986@gmail.com>"

  def self.version
    "v#{VERSION}-#{RELEASE} \"#{CRYPTONYM}\", (c) #{Date.today.year} #{AUTHOR}"
  end
end
