class DashboardsController < ApplicationController
	def index
		@users = User.all.includes(:interests)
	end
end