class User < ApplicationRecord
  has_secure_password
  has_attached_file :img, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  validates :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  # validates_attachment_content_type :user, :content_type => /\Aimage\/.*\Z/

  has_many :user_gigs
  has_many :gigs, through: :user_gigs
  has_many :gig_applications
  has_many :user_instruments
  has_many :instruments, through: :user_instruments


  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :friend_requests
  has_many :friends, :through => :friendrequests
end
