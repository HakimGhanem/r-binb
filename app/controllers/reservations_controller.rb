class ReservationsController < ApplicationController
# encoding: utf-8
    before_action :authenticate_user! #Condition, il faut que l'utilisateur soit connecté pur pouvoir reserver.
    
    def preload
        
        room = Room.find(params[:room_id])
        today = Date.today
        reservations = room.reservations.where("start_date >= ? OR end_date >= ?", today, today)
        
        render json: reservations
    end
    
    def preview
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])
        
        output = {
            conflict: is_conflict(start_date, end_date)
        }
        
        render json: output
    end

    private def is_conflict(start_date, end_date)
        room = Room.find(params[:room_id])
 
        check = room.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
        check.size > 0? true : false
    end
    
    
    def create
        @reservation = current_user.reservations.create(reservation_params)
        redirect_to @reservation.room, notice: "Votre réservation a bien été enregistrée"
    end
    
    def your_trips
        @trips = current_user.reservations
    end
    
    def your_reservations
        @rooms = current_user.rooms
    end
    
    
    private
    def reservation_params
        params.require(:reservation).permit(:start_date,:end_date,:price,:total,:room_id)
        
    end
end