module Abstracta
  #class Engine
  #  attr_accessor :t
  #  attr_accessor :adapter, :reactor
  #  def activate
  #    start
  #    self 
  #  end

  #  def start
  #    puts "--- running!"
  #    @running = true

  #    turn
  #  end

  #  def turn
  #    @reactor.react { |rx| step(rx) }
  #  end

  #  def step(rx)
  #    @t = @t + 1
  #    event("step")
  #  end

  #  def event(name, *args, &blk)
  #    handler = adapt("step", :t => @t)
  #    react("step", handler)
  #  end

  #  #def react(event, handler) # *args, &blk)
  #  #  disruptor = @reactor.disrupt(handler)
  #  #  disruptor.absorb(event)
  #  #end

  #  #def adapt(event) #name, *args, &blk)
  #  #  @adapter.handle(event) #Event.construct(name)
  #  #end
  #end
end
