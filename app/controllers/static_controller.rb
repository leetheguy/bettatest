class StaticController < ApplicationController
	skip_before_filter :require_login
	def index
		@hide_background = true
	end
	def about
	end
	def contact
	end
	def unconfirmed_user
	end
	def unconfirmed_user
	end
end
