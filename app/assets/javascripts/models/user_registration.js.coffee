class Bm.Models.UserRegistration extends Backbone.Model
  url: '/users.json'

  defaults:
    user:
      email: ''
      password: ''
      password_confirmation: ''
