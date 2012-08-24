class Bm.Views.Index extends Backbone.View

  render: ->
    login = new Bm.Views.Login()
    login.render()
    signup = new Bm.Views.Signup()
    signup.render()
    @