class Bm.Views.Pagination extends Backbone.View
  template: JST['common/pagination']
  events:
    'click a': 'showPage'
  separator: '...'

  initialize: (opts) ->
    @update()


  render: ->
    if @pages > 1 # Enable paging
      if @pages > 5 # Not all pages fit..
        if @current_page > 3 # Static link to page 1 is required
          if @current_page < @pages - 2 # Middle section
            pages = [1, @separator, @current_page - 1, @current_page, @current_page + 1, @separator, @pages]
          else # Near end
            pages = [1, @separator, @pages - 3, @pages - 2, @pages - 1, @pages]
        else # Near front
          pages = [1, 2, 3, 4, @separator, @pages]
      else
        pages = [1 .. @pages] # All pages fit
      @$el.html @template
        current_page: @current_page
        last_page: @pages
        pages: pages
    @

  showPage: (event, page) =>
    if event
      event.preventDefault()
      page = $(event.target).attr 'href'
    if page
      @collection.setPage page
      @update()

  update: =>
    @current_page = @collection.getPage()
    @per_page = @collection.getPerPage()
    @collection.getCount (count) =>
      @count = count
      @pages = Math.ceil(parseFloat(@count) / parseFloat(@per_page))
      @render()



