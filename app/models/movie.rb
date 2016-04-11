class Movie < ActiveRecord::Base
	searchkick
	belongs_to :user
	has_many :reviews

	has_attached_file :image, styles: { medium: "300x400#"}
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	validates :title, presence: true
	validates :description, length: { minimum: 10, maximum: 160 }
	validates :movie_length, presence: true
	validates :director, presence: true
	validates :rating, presence: true
	validates_attachment_presence :image
end
