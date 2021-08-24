module DashboardHelper

  #...
  
  def resource
    @resource ||= current_user
  end

  #...

end
