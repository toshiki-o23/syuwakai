class EventsController < ApplicationController
  require 'date'

  before_action :baria_user, only: %i[edit destroy]
  before_action :set_event, only: %i[show edit update destroy]
  before_action :index_case, only: %i[index]
  before_action :authenticate_user!, only: %i[new create update destroy]

  def index
    @q = Event.ransack(params[:q])
    # 現在ユーザーが参加するイベント
    @user_events = UserEvent.where(user_id: current_user.id) if current_user
    @tag_lists = Tag.joins(:tagmaps).group(:tag_id).order('count(tag_name) desc').limit(10)
    @events = Kaminari.paginate_array(@events).page(params[:page]).per(10)
  end

  def new
    if user_signed_in?
      @event = Event.new
    else
      flash[:notice] = '投稿できません!
      ログインしてください!'
      redirect_to events_path
    end
  end

  def create
    @event = Event.new(event_params)
    tag_list = params[:event][:tag_name].split(/[[:blank:]]+/) if params[:tag_name]
    if @event.save
      @event.save_events(tag_list) if tag_list
      redirect_to event_path(@event.id)
    else
      render 'new'
    end
  end

  def show
    @user_event = UserEvent.find_by(user_id: current_user, event_id: params[:id])
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event.id)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(@event.user_id)
    @event.destroy
    redirect_to user_path(@user.id)
  end

  private

  def event_params
    params.require(:event).permit(:title, :content, :number, :image, :level, :venue, :start_time, :finish_time, :fee,
                                  :youtube_url).merge(user_id: current_user.id)
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def baria_user
    # 投稿者以外投稿を編集削除しないように
    return unless Event.find(params[:id]).user_id == current_user.id do;
      flash[:notice] = '権限がありません'
      redirect_to user_path(@user.id)
    end
  end

  def index_case
    # 検索結果orタグ検索結果orフォローしたユーザーの投稿一覧or投稿一覧
    if params[:q].present?
      @q = Event.ransack(params[:q])
      @events = @q.result.includes(%i[user tags tagmaps]).where('start_time > ?', DateTime.now).order(start_time: :asc)
    elsif params[:tag_id].present?
      params[:q] = { sorts: 'id desc' }
      @tag = Tag.find(params[:tag_id])
      @events = @tag.events.includes(%i[user tags tagmaps]).where('start_time > ?', DateTime.now).order(start_time: :asc)
    elsif params[:follow_event_id].present?
      params[:q] = { sorts: 'id desc' }
      @current_user = User.find(params[:follow_event_id])
      @events = Event.includes(%i[user tags tagmaps]).where(user_id: @current_user.following_ids).order(start_time: :asc)
    else
      params[:q] = { sorts: 'id desc' }
      @events = Event.all.includes(%i[user tags tagmaps]).where('start_time > ?', DateTime.now).order(start_time: :asc)
    end
  end
end
