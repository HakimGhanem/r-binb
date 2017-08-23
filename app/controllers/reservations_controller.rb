class ReservationsController < ApplicationController
# encoding: utf-8
    before_action :authenticate_user! #Condition, il faut que l'utilisateur soit connecté pur pouvoir reserver.
    def create
        @reservation = current_user.reservations.create(reservation_params)
        redirect_to @reservation.room, notice: "Votre réservation a bien été enregistrée"
    end
    
    
    private
    def reservation_params
        params.require(:reservation).permit(:start_date,:end_date,:price,:total,:room_id)
        
    end
end