## abstracta

[![Codeship Badge](https://codeship.com/projects/3d50a570-6c46-0132-a8ac-2258e2e8174d/status?branch=master)](https://codeship.com/projects/54005)
[![Code Climate](https://codeclimate.com/github/jweissman/abstracta/badges/gpa.svg)](https://codeclimate.com/github/jweissman/abstracta)
[![Test Coverage](https://codeclimate.com/github/jweissman/abstracta/badges/coverage.svg)](https://codeclimate.com/github/jweissman/abstracta)

* [Homepage](https://rubygems.org/gems/abstracta)
* [Documentation](http://rubydoc.info/gems/abstracta/frames)
* [Email](mailto:jweissman1986 at gmail.com)

## Description

  Cellular automata framework for Ruby

## Features

  * 2-d grid of cells grouped logically into organisms
  * Cell growth behavior governed by easily-configurable "genome"

## Examples

  Again, intentionally abstract, so there's not much output you can 
  derive directly from interacting with it. It might go something like
  this:

    require 'abstracta'
    world = Abstracta::World.new   # creates a sim space 
    100.times { world.step }       # iterates/grows organisms

  In any particular case you'll want to extend from these classes and build on top of
  them. A concrete example from the Biosphere game (probably the place
  to go right now for something to look at around this/inspiration):

    class Cell < Abstracta::Occupant
      def coordinates(cell_size=1)
        x, y = cell.x * self.cell_size, cell.y * self.cell_size
        x1, y1 = x + self.cell_size, y + self.cell_size
        [[x,y], [x1,y], [x, y1], [x1,y1]]
      end

      def render(window, color=Gosu::Color::WHITE)
        coords = coordinates(window.cell_size)
        quad_args = coords.map{|c| c + [color] }
        draw_quad(*quad_args) 
      end
    end

## Requirements

  Everything gosu needs, which is really not all that bad. But it's not exactly portable,
  or easy stand up a dev environment through a simple provisioning script (though maybe a
  little focused effort there could help containerize it.)

## Install

    $ gem install biosphere

## Synopsis

    $ biosphere

## Copyright

Copyright (c) 2014 Joseph Weissman

See {file:LICENSE.txt} for details. Abstracta

Cellular automata game :)

The idea is to have a game server where different players' organisms
could interact...


# Dependencies

You will need to

  brew install sdl2 libogg libvorbis

for Gosu's dependencies. Then bundle and rake to play.

Ideally we'll get vagrant setup to build a dev environment for us...

(Eventually we'll want to containerize the server application too, 
although that can be headless... A containerized dev environment
makes sense eventually too once that is reified a bit further. Something
like boxen may not be the worst thing to think about eventually there too.)
