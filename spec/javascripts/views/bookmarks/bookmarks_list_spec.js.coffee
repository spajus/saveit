describe 'Bm.Views.BookmarkList', ->

  afterEach ->
    ($ '#container').empty()

  it 'Should render the collection', ->
    collection = new Bm.Collections.Bookmarks visited: false
    collection.reset generate_bookmarks 10, false
    list = new Bm.Views.BookmarksList
      el: '#container'
      title: 'Fresh'
      visited: false
      collection: collection
    html = list.render().el

    expect(($ 'tr.bookmark').length).toEqual 10, "Didn't render bookmark list"
    expect(($ 'thead tr th').html().match /Fresh/).toBeTruthy "Title not found"

  it 'Should render pagination', ->
    server.autoRespond = false
    collection = new Bm.Collections.Bookmarks
      visited: false
      page: 2
      perPage: 10
    collection.reset generate_bookmarks 10, false
    list = new Bm.Views.BookmarksList
      el: '#container'
      title: 'Fresh'
      visited: false
      collection: collection
    runs ->
      list.render()
      server.respondWith '50'
    waits 1
    runs ->
      expect(($ 'tr.bookmark').length).toEqual 10, "Didn't render bookmark list"
      expect(($ 'thead tr th').html().match /Fresh/).toBeTruthy "Title not found"
      expect(($ 'div.pagination li.active').text().trim()).toEqual '2',
        "Wrong active page"
      expect(($ 'div.pagination li').length).toEqual 7, "Wrong number of pages"
      server.autoRespond = true
