class Tile
  attr_reader :name
  attr_accessor :revealed

  def initialize(name)
    raise "name must be string" unless name.is_a?(String)
    @value = name
    @revealed = false
    self.hide
  end

  def hide
    @name = " "
  end

  def reveal
    @name = @value
  end
end