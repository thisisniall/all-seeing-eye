class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # for running indico
  Indico.api_key = 'ff667312b4808d831f194a6a620053f8'
end
