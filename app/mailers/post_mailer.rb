class PostMailer < ApplicationMailer

  def post_email(user, post)
    @user = user
    @post = post
    mail(to: @user.email, subject: @user.username + " posted a new ride. Join the ride now!")
  end
end
