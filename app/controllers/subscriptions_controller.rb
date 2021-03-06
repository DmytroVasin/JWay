class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!, only: [:index]

  def index
    @subscriptions = Subscription.all
  end

  def create
    subscription = Subscription.new(subscription_params.merge(last_id: find_last_id))

    if subscription.save
      flash[:notice] = 'Подписка оформленна!'
    else
      flash[:alert] = subscription.errors.full_messages.join(', ')
    end

    redirect_to root_path
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    redirect_to subscriptions_path, notice: 'Subscription was deleted!'
  end

  def send_reminder
    last_id = Post.get_last_availible_id
    Subscription.send_notification_with(last_id)

    redirect_to subscriptions_path, notice: 'Subscription was sent!'
  end

  def delete_notifier
    subscriber = Subscription.where(email: params[:email]).first
    subscriber.delete

    redirect_to root_path, notice: 'Подписка удалена!'
  end

  private
  def subscription_params
    params.require(:subscription).permit( :email, :last_id )
  end

  def find_last_id
    Post.available_for(current_user).maximum(:id)
  end
end
