class Bm.Collections.Tags extends Backbone.Collection

  model: Bm.Models.Tag
  url: '/api/tags'

  setSelectedTag: (tag) ->
    @tag = tag

  reset: =>
    result = super
    selected_tag = @tag
    @each (tag) =>
      if tag.getSlug() is selected_tag
        tag.setSelected true
        return result
    result
