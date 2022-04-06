class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /events or /events.json
  def index
    events = current_user.events
    current_user.friends.each { |friend| events.concat(friend.events.where.not(privacy: "only_me")) }
    @events = events.sort_by { |event| -event.created_at.to_i }
  end

  # GET /events/1 or /events/1.json
  def show
    @going = []
    @interested = []
    current_user.friends.each{
      |friend| 
      if friend.going_to_events.include?(@event)
        
        @going.append(friend)
      end
      if friend.interested_to_events.include?(@event)
        @interested.append(friend)
      end
    }
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)
    @event.user = current_user

    respond_to do |format|
      if @event.save
        message = "#{current_user.user_name} added new event #{@event.name}"
        scope = @event.privacy == "only_me" ? [] : current_user.friends
        SendNotificationsJob.perform_now({:message => message, :scope => scope})
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /going
  def save_going
    @event = Event.find(params[:event_id])
    @event.going.append(current_user)
    if @event.interested.include?(current_user)
      @event.interested.delete(current_user)
    end
    redirect_to event_url(@event)
  end

  # POST /interested
  def save_interested
    @event = Event.find(params[:event_id])
    @event.interested.append(current_user)
    if @event.going.include?(current_user)
      @event.going.delete(current_user)
    end
    redirect_to event_url(@event)
  end
  
  # DELETE /events/1/delete_invitation
  def delete_invitation
  # Delete invitation on responding
  end

  # DELETE /events/1/delete_response
  def delete_response
    @event = Event.find(params[:event_id])
    if @event.going.include?(current_user)
      @event.going.delete(current_user)
    else
      @event.interested.delete(current_user)
    end
    redirect_to event_url(@event)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :date, :description, :online_InPerson, :post_permission, :invite_permission, :location, :privacy, status)
    end
end
