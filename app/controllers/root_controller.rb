class RootController < ApplicationController
  def sandbox
  	session[:our_data] = 1234
  end
  def home
  	redirect_to posts_path if signed_in?
  end
end
