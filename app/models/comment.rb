class Comment < ApplicationRecord
    belongs_to :glob
    
    validates :body, presence: true
    validates :contributor, presence: true
    validates :contact, presence: true
end
