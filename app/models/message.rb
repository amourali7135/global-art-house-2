class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :body, :conversation_id, :user_id
  # after_create :mark_own_message_as_read

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

  # def mark_own_message_as_read
  #   if self.user == User.find
  #     self.read == true
  #     self.save!
  #   end
  # end


end



# belongs_to :conversation
# belongs_to :user
# validates :body, presence: true



# def message_time
#   created_at.strftime("%m/%d/%y at %l:%M %p")
# end
