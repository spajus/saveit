class Bm.Models.UserRegistration extends Backbone.Model
  url: '/users.json'

  defaults:
    user:
      email: ''
      password: ''
      password_confirmation: ''

  validate: (attrs) ->
    unless attrs.user.email
      return "Email can't be empty!"
    unless attrs.user.password.length > 5
      return "Password must be at least 6 characters long"
    unless attrs.user.password is attrs.user.password_confirmation
      return "Passwords do not match"

