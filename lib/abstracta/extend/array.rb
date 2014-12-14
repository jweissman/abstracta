PARALLELISM = 1

class Array
  def x; first  end
  def y; second end
  def z; third  end
  def t; fourth end

  def parallel_each(name="please wait...", &blk)
    if PARALLELISM == 1
      each(&blk)
    else
      Parallel.each(self, in_threads: PARALLELISM, progress: name, &blk)
    end
  end
end
