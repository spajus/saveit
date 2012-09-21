class Bm.Views.Navbar extends Backbone.View
  template: JST['common/navbar']
  el: '#navbar'

  events:
    'click .signout-link': 'signout'
    'click .nav-link': 'navigate'

  render: ->
    if gon.current_user
      @$el.html @template()

  signout: (e) ->
    e.preventDefault()
    $.ajax
      url: '/users/sign_out'
      type: 'DELETE'
      success: ->
        window.location.assign('/')

  navigate: (e) ->
    app.navigate e.target.pathname, trigger: true
    if e.target.pathname is '/'
      app.indexView.collection.fetch()
    e.preventDefault()


