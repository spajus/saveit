class Bm.Models.Tag extends Backbone.Model

  urlRoot: '/api/tags'

  getSlug: ->
    @get('name').replace ' ', '-'
