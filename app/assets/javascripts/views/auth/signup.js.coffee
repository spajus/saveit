class Bm.Views.Signup extends Backbone.View

  el: '#signup'
  template: JST['auth/signup']
  events:
    'submit form': 'signup'

  initialize: ->
    @model = new Bm.Models.UserRegistration()

  render: ->
    @$el.html @template()
    @

  signup: (e) ->
    e.preventDefault()

    @model.save
      user:
        email: (@$ '#email').val()
        password: (@$ '#password').val()
        password_confirmation: (@$ '#password_confirmation').val()
      ,
        success: (user_session, response) =>
          console.log 'ok', user_session, response
        error: (object, response) =>
          error_msg = ""
          if response.status is 401
            error_msg = ($.parseJSON response.responseText).error
          else
            error_msg = response
          (@$ ".control-group").addClass 'error'
          show_alert error_msg

