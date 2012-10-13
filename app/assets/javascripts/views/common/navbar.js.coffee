class Bm.Views.Navbar extends Backbone.View
  template: JST['common/navbar']
  el: '#navbar'

  events:
    'click .nav-link': 'navigate'

  render: ->
    if gon.current_user
      @$el.html @template()

  navigate: (e) ->
    app.navigate e.target.pathname, trigger: true
    if e.target.pathname is '/'
      app.indexView.collection.fetch()
      app.indexView.tag_collection.fetch()
    e.preventDefault()
