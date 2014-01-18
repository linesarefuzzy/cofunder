class ProgressMetric < ActiveRecord::Base
  include Legacy
  self.primary_key = 'Level'
  attr_accessible :EnglishDisplayContinuous, :EnglishDisplayWithEvents, :SpanishDisplayContinuous, :SpanishDisplayWithEvents, :level
end
