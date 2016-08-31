class QuarterlyMessagesController < ApplicationController
  before_action :current_user_admin, only: [:new, :create, :edit, :update]
	before_action :find_quarterly_message, only: [:edit, :update, :destroy]
	
	def index
		@quarterly_messages = QuarterlyMessage.
			filter(params).
			page(params[:page])
	end

	def new
		@quarterly_message = QuarterlyMessage.new
	end

	def create
		@quarterly_message = QuarterlyMessage.new(quarterly_message_params)
		if @quarterly_message.save
			flash[:notice] = I18n.t('controllers.quarterly_messages_controller.notices.create')
			redirect_to root_path
		else
			flash.now[:error] = I18n.t('controllers.quarterly_messages_controller.errors.create')
			render action: :new
		end
	end

	def edit
	end

	def update
		if @quarterly_message.update(quarterly_message_params)
			flash[:notice] = I18n.t('controllers.quarterly_messages_controller.notices.update')
			redirect_to quarterly_messages_path
	end

	def destroy
    @quarterly_message.destroy
    flash.notice = I18n.t('controllers.quarterly_messages_controller.notices.destroy', quarterly_message_title: @quarterly_message.title)
    redirect_to quarterly_messages_path
	end

	private

  def find_quarterly_message
    @quarterly_message = QuarterlyMessage.find(params[:id])
  end

	def quarterly_message_params
    params.require(:quarterly_message).permit(:title, :body, :tag_list)
	end

end