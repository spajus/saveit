class Bm.Models.UserPasswordRecovery extends Backbone.Model
  url: '/users/password.json'
  paramRoot: 'user'

  defaults:
    email: ''
