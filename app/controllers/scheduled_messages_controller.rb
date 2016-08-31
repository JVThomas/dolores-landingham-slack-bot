class ScheduledMessagesController < ApplicationController
  before_action :current_user_admin, only: [:new, :create, :edit, :update]
  before_action :find_scheduled_message, only: [:edit, :update, :destroy]

  def new
    @scheduled_message = ScheduledMessage.new
  end

  def create
    @scheduled_message = ScheduledMessage.new(scheduled_message_params)

    if @scheduled_message.save
      flash[:notice] = I18n.t('controllers.scheduled_messages_controller.notices.create')
      redirect_to root_path
    else
      flash.now[:error] = I18n.t('controllers.scheduled_messages_controller.errors.create')
      render action: :new
    end
  end

  def index
    @scheduled_messages = ScheduledMessage.
      filter(params).
      date_time_ordering.
      page(params[:page])
  end

  def edit
  end

  def update
    if @scheduled_message.update(scheduled_message_params)
      flash[:notice] = I18n.t('controllers.scheduled_messages_controller.notices.update')
      redirect_to scheduled_messages_path
    else
      flash.now[:error] = I18n.t('controllers.scheduled_messages_controller.errors.update')
      render action: :edit
    end
  end

  def destroy
    @scheduled_message.destroy
    flash[:notice] = I18n.t('controllers.scheduled_messages_controller.notices.destroy', scheduled_message_title: @scheduled_message.title)
    redirect_to scheduled_messages_path
  end

  private

  def find_scheduled_message
    @scheduled_message = ScheduledMessage.find(params[:id])
  end

  def scheduled_message_params
    params.
      require(:scheduled_message).
      permit(
        :body,
        :days_after_start,
        :end_date,
        :tag_list,
        :time_of_day,
        :title,
        :type,
      )
  end
end
