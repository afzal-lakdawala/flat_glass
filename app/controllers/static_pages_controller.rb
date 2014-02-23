class StaticPagesController < ApplicationController

  def index
    @orders = Order.last31Days
  end
    
  #------------- APIs ----------------
  
  def tinycon
    return 6
  end
      
end
