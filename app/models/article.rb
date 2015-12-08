class Article < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: {minimum: 20}
	before_save :set_visits_count

	has_attached_file :cover, styles: { medium: "1280x720", thumb: "600x400"}
	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

	def update_visits_count
		self.visits_count ||= 0
		self.update(visits_count: self.visits_count + 1)
	end

	private
	def set_visits_count
		self.visits_count ||= 0
	end

end
