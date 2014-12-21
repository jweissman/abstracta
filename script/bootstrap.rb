#!/usr/bin/enb ruby

#
root = File.expand_path(File.join(File.dirname(__FILE__),'..'))
if File.directory?(File.join(root,'.git'))
  Dir.chdir(root) do
    begin
      require 'bundler/setup'
      require 'abstracta'
      Engine.boot
    rescue LoadError => e
      warn e.message
      warn "Run `gem install bundler` to install Bundler"
      exit(-1)
    end
  end
end
