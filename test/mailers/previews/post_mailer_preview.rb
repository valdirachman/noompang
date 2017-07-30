# Preview all emails at http://localhost:3000/rails/mailers/post_mailer
class PostMailerPreview < ActionMailer::Preview

  def post_email
    PostMailer.post_email(Post.first.user, Post.first)
  end
end
