class Bm.Views.Login extends Backbone.View

  el: '#login'
  template: JST['auth/login']
  events:
    'submit form': 'login'

  initialize: ->
    @model = new Bm.Models.UserSession()

  render: ->
    @$el.html @template()
    @

  login: (e) ->
    e.preventDefault()

    @model.save
      user:
        email: (@$ '#email').val()
        password: (@$ '#password').val()
      ,
        success: (user_session, response) =>
          gon.current_user = user_session
          show_alert 'Welcome back', 'info'
          app.index()

        error: (object, response) =>
          error_msg = ""
          if response.status is 401
            error_msg = ($.parseJSON response.responseText).error
          else
            error_msg = response
          (@$ ".control-group").addClass 'error'
          show_alert error_msg

