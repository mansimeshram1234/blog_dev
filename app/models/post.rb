class Post < ApplicationRecord
	has_many :comments, dependent: :destroy ,as: :commentable
	belongs_to :user
	
	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings
	validates :title, presence: true, length: { minimum: 5}
	validates :body,presence: true

def self.tagged_with(title)
	Tag.find_by!(title: title).posts
end

def all_tags=(titles)
	self.tags=titles.split(',').map do |title|
		Tag.where(title: title).first_or_create!
  end
end

def all_tags
	self.tags.map(&:title).join(", ")
	end
end	


