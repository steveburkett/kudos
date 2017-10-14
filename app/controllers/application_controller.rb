class ApplicationController < ActionController::Base
  include ErrorHandling

  before_action :authenticate_user!
end
