module Abstracta
  MAJOR = 0
  MINOR = 1
  TINY  = 1
  MICRO = 1
  NANO  = 1

  VERSION   = [ MAJOR, MINOR, TINY, MICRO, NANO ].join('.')
  RELEASE   = "prealpha"
  CRYPTONYM = "turquoise-polygon"
  AUTHOR    = "Joseph Weissman <jweissman1986@gmail.com>"

  def self.version
    "v#{VERSION}-#{RELEASE} \"#{CRYPTONYM}\", (c) #{Date.today.year} #{AUTHOR}"
  end
end
