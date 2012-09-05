class Bm.Models.UserSession extends Backbone.Model
  url: '/users/sign_in.json'

  defaults:
    user:
      email: ''
      password: ''
