class Bm.Views.Bookmarklet extends Backbone.View

  template: JST['bookmarklets/bookmarklet']

  render: ->
    @$el.html @template(bookmarklet_js: gon.bookmarklet_js)
    @
