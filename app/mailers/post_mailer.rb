class PostMailer < ActionMailer::Base

  def post_created(current_user,post_user)

    @current_user = current_user
    @post_user = post_user


    mail( to: post_user.email,
          from: "services@gmail.com",
          subject: "Join the Ride!",
        )
  end

end
