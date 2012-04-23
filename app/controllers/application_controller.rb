class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_basics

  def index
    redirect_to "/intervals" if user_signed_in?
  end

  private
    def check_basics
      if user_signed_in? and current_user.basic.nil?
        link = "<a href=\"#{url_for(new_basic_path)}\">Click here.</a>"
        flash[:notice] = "Please, tell us a little more about your working time. #{link}".html_safe
      end
    end
end
