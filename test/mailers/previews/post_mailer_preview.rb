# Preview all emails at http://localhost:3000/rails/mailers/post_mailer
class PostMailerPreview < ActionMailer::Preview

  def post_email
    PostMailer.post_email(Post.first.user, Post.first)
  end

  def new_driver_post
    PostMailer.new_driver_post(DriverPost.first.user, DriverPost.first)
  end

  def new_pickup
    PostMailer.new_pickup(DriverPost.first.user, DriverPost.first, User.last)
  end

  def accept_pickup
    PostMailer.accept_pickup(DriverPost.first.user, DriverPost.first, User.last)
  end

  def reject_pickup
    PostMailer.reject_pickup(DriverPost.first.user, DriverPost.first, User.last)
  end

  def new_join
    PostMailer.new_join(DriverPost.first.user, DriverPost.first, User.last)
  end

  def accept_join
    PostMailer.accept_join(DriverPost.first.user, DriverPost.first, User.last)
  end

  def reject_join
    PostMailer.reject_join(DriverPost.first.user, DriverPost.first,User.last)
  end
end
