class Bm.Models.Bookmark extends Backbone.Model

  urlRoot: '/api/bookmarks'

  validate: (attrs) ->
    unless attrs.url
      return "url can't be empty!"
    url = attrs.url.toLowerCase()
    unless url.indexOf('http://') is 0
      unless url.indexOf('https://') is 0
        return "url must start with http:// or https://"

  getCreatedAt: ->
    created_at = @get 'created_at'

