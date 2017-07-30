class PostMailer < ApplicationMailer

  def post_email(user, post)
    @user = user
    @post = post
    mail(to: @user.email, subject: "Join " + @user.username + "'s ride!")
  end
end
