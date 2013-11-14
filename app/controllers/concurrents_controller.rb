class ConcurrentsController < ApplicationController
  @counter = 0

  class << self
    attr_accessor :counter
  end


  trap(:TTIN) {
    $stderr.puts " Count: #{ConcurrentsController.counter}"
  }

  def index
    counter = self.class.counter # read
    sleep(0.1)
    counter += 1                 # update
    sleep(0.1)
    self.class.counter = counter # write

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end

  end
end