class Bm.Views.Bookmarklet extends Backbone.View

  template: JST['bookmarklets/bookmarklet']
  events:
    'click a': 'bookmarkletHelp'

  render: ->
    @$el.html @template(bookmarklet_js: gon.bookmarklet_js)
    @

  bookmarkletHelp: (event) ->
    event.preventDefault()
    window.alert("Drag this bookmarklet into your bookmarks bar and click \
it while visiting interesting places. Then come back to saveit.in.");

