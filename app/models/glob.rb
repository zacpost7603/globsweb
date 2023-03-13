class Glob < ApplicationRecord
    belongs_to :user
    has_many :comments
    
    validates :title, presence: true
    validates :summary, presence: true
    validates :author, presence: true
end
