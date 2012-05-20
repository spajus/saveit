class Bm.Models.Bookmark extends Backbone.Model

  validate: (attrs) ->
    unless attrs.url
      return "url can't be empty!"
