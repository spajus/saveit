class Bm.Models.Tag extends Backbone.Model

  urlRoot: '/api/tags'

  setSelected: (selected) =>
    @set 'selected', selected
    @trigger 'selected', @
    @

  isSelected: ->
    @get 'selected'

  getSlug: ->
    @get('name').replace /\s/g, '-'
