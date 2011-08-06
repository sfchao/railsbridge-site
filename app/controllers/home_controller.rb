class HomeController < ApplicationController

  def detect
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    locale = "en" unless locale == "es"
    redirect_to root_path(:locale => locale)
  end
end
