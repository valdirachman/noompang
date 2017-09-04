OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, '1468686219865206', 'eb64180d6db0934a77706612c0267e87'
end
