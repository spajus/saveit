Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'mRaxR11KHsujUROpi7mdig', 'dRLGaAirZdsbsfOvg8IpHR6pTNNeEDCiA0yrvni8qA'
  provider :facebook, '321764964568044', 'b49e77d860de555b777bd79d6581efe1'
end