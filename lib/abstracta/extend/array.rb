PARALLELISM = 1

class Array
  def x; first  end
  def y; second end
  def z; third  end
  def t; fourth end

  def sum
    inject(&:+) #(0.0) { |result, el| result + el }
  end

  def mean 
    sum / size
  end  

  def parallel_map(name="please wait...", &blk)
    if PARALLELISM == 1
      map(&blk)
    else
      Parallel.map(self, in_threads: PARALLELISM, progress: name, &blk)
    end
  end

  def parallel_each(name="please wait...", &blk)
    if PARALLELISM == 1
      each(&blk)
    else
      Parallel.each(self, in_threads: PARALLELISM, progress: name, &blk)
    end
  end


  ###
  #
  #  i have this idea that we could make "finders" methods on array act more sweetly...
  #
end
