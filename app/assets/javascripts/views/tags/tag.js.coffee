class Bm.Views.Tag extends Backbone.View

  template: JST['tags/tag']
  tagName: 'tr'
  className: 'tag'

  events:
    'click a.close': 'removeTag'

  id: =>
    "tag-#{@model.get 'id'}"

  render: =>
    @$el.html @template tag: @model
    unless @alreadyDroppable
      @alreadyDroppable = true
      @$el.droppable
        hoverClass: 'tag-hover'
        drop: (event, ui) =>
          ui.draggable.draggable 'option', 'revert', false
          bookmark = ui.draggable.data 'bookmark'
          tag_names = bookmark.get('tag_names') or []
          tag_names.push @model.get 'name'
          bookmark.save tag_names: tag_names, {wait: true}
          bookmark.trigger 'change'
          @collection.fetch()
    @

  removeTag: (event) ->
    remove = true
    if user_settings.getConfirmDelete()
      unless confirm "Are you sure you want to delete tag: '#{@model.get 'name'}'?"
        remove = false
    if remove
      @model.destroy wait: true

