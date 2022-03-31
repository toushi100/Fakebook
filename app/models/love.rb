class Love < React
    belongs_to :user
    belongs_to :post
    belongs_to :comment
  
    validates :user_id, uniqueness: { scope: :post_id }
end
