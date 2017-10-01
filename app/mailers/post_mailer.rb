class PostMailer < ApplicationMailer

  def post_email(user, post)
    @user = user
    @post = post
    mail(to: @user.email, subject: 'New ride request from ' + @post.user.username)
  end

  def new_driver_post(user, post)
    @user = user
    @post = post
    mail(to: @user.email, subject: 'New ride offer from ' + @post.user.username)
  end

  # [RIDER] nerima email pick up
  def new_pickup(driver, post, rider)
    @rider = rider
    @driver = driver
    @post = post
    mail(to: @rider.email, subject: driver.username + ' offers you to join their ride!')
  end

  # [DRIVER] nerima email rider accept pickup
  def accept_pickup(driver, post, rider)
    @rider = rider
    @driver = driver
    @post = post
    mail(to: @driver.email, subject: rider.username + ' has accepted your ride offer!')
  end

  # [DRIVER] nerima email rider reject pickup
  def reject_pickup(driver, post, rider)
    @rider = rider
    @driver = driver
    @post = post
    mail(to: @driver.email, subject: rider.username + ' has rejected to join your ride')
  end

  # [DRIVER] nerima email join
  def new_join(driver, post, rider)
    @rider = rider
    @driver = driver
    @post = post
    mail(to: @driver.email, subject: rider.username + ' wants to join your ride!')
  end

  # [RIDER] nerima email kalo dia di pick up driver
  def accept_join(driver, post, rider)
    @rider = rider
    @driver = driver
    @post = post
    mail(to: @rider.email, subject: driver.username + ' has accepted you to join their ride!')
  end

  # [RIDER] nerima email kalo dia di reject driver
  def reject_join(driver, post, rider)
    @rider = rider
    @driver = driver
    @post = post
    mail(to: @rider.email, subject: driver.username + ' has rejected you to join their ride')
  end
end
