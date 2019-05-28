class Activity < PublicActivity::Activity
  scope :by_activity_following, (lambda do |owner_ids|
    where owner_id: owner_ids
  end)
  scope :newest, ->{order created_at: :desc}
end
