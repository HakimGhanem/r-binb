class PhotosController < ApplicationController
    
    def destroy
        
        @photo = Photo.find(params[:id]) # Correspond à l'id de la photo cocernée
        room = @photo.room
        
        @photo.destroy
        
        @photos = Photo.where(room_id: room.id) #Réactualise la liste des photos de ce logement
        
        respond_to :js #Suppression immédiate
    end
    
end
