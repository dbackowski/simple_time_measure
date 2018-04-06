require 'spec_helper'

describe 'DummyTestClass that include SimpleTimeMeasure' do
  subject {
    class DummyTestClass
      include SimpleTimeMeasure

      @@time_measures = {}

      measure_instance_method :test do |result|
        @@time_measures[:test] = result
      end

      measure_class_method :test2 do |result|
        @@time_measures[:test2] = result
      end

      def test
        1
      end

      def self.test2
        2
      end

      def self.time_measures
        @@time_measures
      end
    end

    DummyTestClass
  }

  describe '#test' do
    it 'returns 1' do
      expect(subject.new.test).to eq 1
      expect(subject.time_measures[:test]).to have_key(:cpu_time)
      expect(subject.time_measures[:test]).to have_key(:wall_time)
      expect(subject.time_measures[:test]).to have_key(:idle_time)
    end
  end

  describe '.test2' do
    it 'returns 2' do
      expect(subject.test2).to eq 2
      expect(subject.time_measures[:test2]).to have_key(:cpu_time)
      expect(subject.time_measures[:test2]).to have_key(:wall_time)
      expect(subject.time_measures[:test2]).to have_key(:idle_time)
    end
  end
end
