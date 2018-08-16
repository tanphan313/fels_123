class Activity < ActiveRecord::Base
  belongs_to :user

  scope :destroy_lesson, ->lesson,action_type{where("target_id = #{lesson.id} AND action_type = #{action_type}")}
  scope :destroy_user, ->user, followed, unfollwed{where("target_id = #{user.id} AND
   (action_type = #{followed} OR action_type = #{unfollwed})")}
end
