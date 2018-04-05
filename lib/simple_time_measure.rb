require "simple_time_measure/version"

module SimpleTimeMeasure
  def self.included(base)
    self.base_singleton_class = base.singleton_class
    base.extend ClassMethods
  end

  private

  def self.cpu_time
    Process.clock_gettime(Process::CLOCK_PROCESS_CPUTIME_ID, :microsecond)
  end

  def self.wall_time
    Process.clock_gettime(Process::CLOCK_MONOTONIC, :microsecond)
  end

  def self.time
    cpu_time = SimpleTimeMeasure.cpu_time
    wall_time = SimpleTimeMeasure.wall_time
    yield
    cpu_time = SimpleTimeMeasure.cpu_time - cpu_time
    wall_time = SimpleTimeMeasure.wall_time - wall_time
    idle_time = wall_time - cpu_time
    { cpu_time: cpu_time, wall_time: wall_time, idle_time: idle_time }
  end

  def self.base_singleton_class
    @base_singleton_class
  end

  def self.base_singleton_class=(base_singleton_class)
    @base_singleton_class = base_singleton_class
  end

  module ClassMethods
    def measure_instance_method(name)
      m = Module.new do
        define_method name do |*args|
          result = nil
          time = SimpleTimeMeasure.time do
            result = super(*args)
          end
          yield(time) if block_given?
          result
        end
      end

      prepend m
    end

    def measure_class_method(name)
      m = Module.new do
        define_method name do |*args|
          result = nil
          time = SimpleTimeMeasure.time do
            result = super(*args)
          end
          yield(time) if block_given?
          result
        end
      end

      SimpleTimeMeasure.base_singleton_class.prepend m
    end
  end
end
