class Bm.Views.Navbar extends Backbone.View
  template: JST['common/navbar']
  el: '#navbar'

  events:
    'click .signout-link': 'signout'

  render: ->
    if gon.current_user
      @$el.html @template()

    @bookmarklet = new Bm.Views.Bookmarklet el: '#bookmarklet'
    @bookmarklet.render()
    @

  signout: (e) ->
    e.preventDefault()
    $.ajax
      url: '/users/sign_out'
      type: 'DELETE'
      success: ->
        window.location.assign('/')
