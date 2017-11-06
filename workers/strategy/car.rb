class Car
  def initialize(engine)

    @engine = engine
  end

  def main
  	car_a = Car.new(StraightSixEngine.new)
		car_b = Car.new(V8Engine.new)
  end
end

# Engine strategy 1
class StraightSixEngine

  def start
  end

  def stop
  end
end

# Engine strategy 2
class V8Engine

  def start
  end

  def stop
  end
end
