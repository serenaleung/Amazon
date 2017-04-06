class Ability
  include CanCan::Ability

  def initialize(user)
    # as per comments above `user` here refers to `current_user`

    # if the user isn't logged in, which means `user` comes as `nil`, then `user`
    # will be assigned to `User.new`. This is useful so we don't have to check if
    # `user` is `nil` all the time
    user ||= User.new

    if user.is_admin?
      # this gives the admin user super powers by enabling them to perform any
      # action on any model
      can :manage, :all
    end

    # in this ex. we're saying that the user can edit a question if the user
    # is the owner (creator) of that question
    can [:edit, :destroy], Product do |product|
      product.user == user
    end

    # OR
    # `user_id` is inside the `questions` table and `user` is either the signed
    # in user (if the user is signed in) or `User.new` as per line 14
    # can :edit, Question, user_id: user.id

    # to learn more about defining abilities in CanCanCan you can check out:
    # https://github.com/CanCanCommunity/cancancan/wiki/defining-abilities
  end
end
