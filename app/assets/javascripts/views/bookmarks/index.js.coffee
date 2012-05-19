class Bm.Views.BookmarksIndex extends Backbone.View

  template: JST['bookmarks/index']

  render: ->
    @$el.html @template()
    @

