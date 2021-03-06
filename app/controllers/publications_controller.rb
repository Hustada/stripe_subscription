class PublicationsController < ApplicationController
	before_filter :check_for_subscription, only: :show
	
	def index
		@publications = Publication.all
	end

	def show
		@publication = Publication.find(params[:id])
	end

	def check_for_subscription
		unless current_user.plan.active?
			flash[:notice] = "You must be subscribed to access this content"
			redirect_to	publications_path
	end
end

end