class EventsController < ApplicationController
before_filter :authenticate_user!, :only => [:follow_index, :new, :create, :destroy, :edit, :update]
before_filter :authenticate_same_user, :only => [:update, :destroy, :edit]

  def authenticate_same_user
    @event = Event.find(params[:id])
      if current_user == @event.user
        true
      else
        redirect_to event_path(@event), :alert => "You are not authorized to edit this event"
      end
  end

  def index
    @events = Event.order("created_at DESC").page(params[:page]).per(6)
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def follow_index
    @events = []
    current_user.follows.each do |follow|
      @events += Event.where(:user_id => follow.follower_id)
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @client = Soundcloud.new(:client_id => "5ba473964263fd02eec8f08732b65d4f")
    
  end

  def create
    @event = Event.new(params[:event])
    @event.user = current_user
    if @event.save
      @user_list = []
      
      @follows = Follow.where(:follower_id => @event.user.id)
      
      @follows.each do |follow|
          @user_list += User.where(:id => follow.user_id) 
      end
     
      @user_list.each do |user|
        EventMailer.new_event_notify(user, @event).deliver
      end

      redirect_to @event, notice: ':) event was created.'
      else
      flash[:error] = "There were some errors creating your event. :("
      render action: "new"
      end
  end

  def edit
    @event = Event.find(params[:id])
    @client = Soundcloud.new(:client_id => "5ba473964263fd02eec8f08732b65d4f")
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
        redirect_to @event, notice: ':) Event was updated.'
    else
      flash[:error] = "There were some errors creating your event. :("
      render action: "edit"
    end
  end

  def destroy
    @event = Event.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to events_url }
    end
  end
end
