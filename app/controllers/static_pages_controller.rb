class StaticPagesController < ApplicationController

  def index
    @orders = Order.getGroupedlast31Days.to_json
  end
    
  #------------- APIs ----------------
  
  def tinycon
    return 6
  end
      
end
