require 'countdownlatch'

class ElectricSlide
  class QueuedCall
    attr_accessor :call, :queued_time

    def initialize(call)
      @call = call
      @queued_time = Time.now
    end

    def hold
      call.execute 'StartMusicOnHold'
      @latch = CountDownLatch.new 1
      @latch.wait
      call.execute 'StopMusicOnHold'
    end

    def make_ready!
      @latch.countdown!
    end
  end
end

