class Bm.Models.Bookmark extends Backbone.Model

  urlRoot: '/api/bookmarks'

  validate: (attrs) ->
    unless attrs.url
      return "url can't be empty!"
