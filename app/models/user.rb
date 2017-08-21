class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :fullname, presence:true, length: {maximum: 50}
  
  
  #PaperClip
has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                  :default_url => "/assets/default_image.png"
validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

# Model Room

has_many:rooms  #Un user peut avoir une ou plusieurs annonces de logement

validates :home_type, presence: true  #la variable type d’habitation sera nécessaire pour la création d’une annonce  
           validates :room_type, presence: true


           validates :accommodate, presence: true


           validates :bed_room, presence: true


           validates :bath_room, presence: true


           validates :listing_name, presence: true, length: {maximum: 75} # 75 caractères max  
           validates :summary, presence: true, length: {maximum: 600}


           validates :address, presence: true


           validates :price, numericality: { only_integer: true, greater_than: 5 } #seulement des nombres entiers supérieurs à 5
end
