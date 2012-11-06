class Bm.Views.ImportExport extends Backbone.View 

  el: '#container'

  template: JST['bookmarks/import_export']
  events:
    'click #bookmarks-export': 'export'
    'click #bookmarks-import': 'import'

  render: ->
    @$el.html @template csrf_token: $('meta[name="csrf-token"]').attr 'content'

  export: ->
    window.location.assign '/bookmarks-export'

  import: ->
    if ($ "#new-bookmarks-file").val()
      ($ "#bookmarks-import-form").submit()
    else
      show_alert "Please select a file first"
    
    
  
