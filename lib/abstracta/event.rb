#class Abstracta::Event #< OpenStruct.new 
#  
#  def self.construct(name, attrs={}, &blk)
#    new({:name => name}).merge(attrs)
#  end
#
#  def id
#    @id ||= SecureRandom.uuid
#  end
#
#  def attributes
#    { 
#      :identifier => self.id, 
#      :name => self.name,
#      :description => self.description
#    }
#  end
#end
#
#
