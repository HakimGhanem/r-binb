class User < ActiveRecord::Base
    
has_many :rooms  #Un user peut avoir une ou plusieurs annonces de logement
has_many :reservations
has_many :reviews


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :fullname, presence:true, length: {maximum: 50}
  
  
  #PaperClip
has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                  :default_url => "/assets/default_image.png"
validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

# Model Room

def self.from_omniauth(auth)
    user=User.where(email: auth.info.email).first
    if user
        return user
    else
        where(provider: auth.provider, uid: auth.uid).first_or_create do |u|
            u.fullname = auth.info.name
            u.provider = auth.provider
            u.uid = auth.uid
            u.email = auth.info.email
            u.image = u.auth.image
            u.password = Devise.friendly_token[0,20]
        end
    end
end


end
