describe 'Bm.Views.Bookmark', ->

  it 'Should render without tags', ->

    expect(user_settings.getUseTags()).toBeFalsy()

    example_com = test_bookmarks.example_com

    view = new Bm.Views.Bookmark
      model: example_com
    html = view.render().el

    tag_drag = ($ html).find 'div.drag-tag'
    expect(tag_drag.length).toEqual 0, 'tag dragger found'

    link = ($ html).find 'a.link'
    expect(link.attr 'href').toEqual example_com.get('url'), 'bad url'
    expect(link.text()).toEqual example_com.get('title'), 'bad title'

    icon = ($ html).find 'i'
    expect(icon.hasClass 'icon-globe').toBeTruthy 'no icon'

    date = ($ html).find 'div.date'
    expect(date.text().trim()).toEqual example_com.get('created_at'), 'bad date'

    tags = ($ html).find 'div.tags'
    expect(tags.length).toEqual 0, 'tags not disabled'

    close = ($ html).find 'a.close'
    expect(close.length).toEqual 1, 'delete link not found'

  it 'Should render with tags', ->

    stub = sinon.stub user_settings, 'getUseTags', -> true

    expect(user_settings.getUseTags()).toBeTruthy()

    example_com = test_bookmarks.example_com

    view = new Bm.Views.Bookmark
      model: example_com
    html = view.render().el
    console.log html

    tag_drag = ($ html).find 'div.drag-tag'
    expect(tag_drag.length).toEqual 1, 'tag dragger not found'
    expect(tag_drag).toBeHidden 'tag drag is visible'

    bookmark = ($ html).find 'div.bookmark-content'

    link = ($ bookmark).find 'a.link'
    expect(link.attr 'href').toEqual example_com.get('url'), 'bad url'
    expect(link.text()).toEqual example_com.get('title'), 'bad title'

    icon = ($ bookmark).find 'i'
    expect(icon.hasClass 'icon-globe').toBeTruthy 'no icon'

    date = ($ bookmark).find 'div.date'
    expect(date.text().trim()).toEqual example_com.get('created_at'), 'bad date'

    tags = (($ bookmark).find 'div.tags').html()
    expect(tags.match /one/).toBeTruthy 'tag "one" not rendered'
    expect(tags.match /two/).toBeTruthy 'tag "one" not rendered'

    close = ($ bookmark).find 'a.close'
    expect(close.length).toEqual 1, 'delete link not found'

    stub.restore()

  it 'Should open bookmark when link gets clicked', ->

    spy_link = test_bookmarks.spy_link.clone() #Gonna modify it
    expect(spy_link.get 'visited').toBeFalsy 'visited should be false'

    collection = new Bm.Collections.Bookmarks visited: false
    spy = sinon.spy()
    collection.on 'open-bookmark', spy

    view = new Bm.Views.Bookmark
      model: spy_link
      collection: collection

    html = view.render().el

    link = ($ html).find 'a.link'
    link.click()

    expect(spy.called).toBeTruthy "click didn't work"
    expect(spy_link.get 'visited').toBeTruthy 'visited not set on model'


  it 'Should remove bookmark when [x] gets clicked', ->

    stub = sinon.stub user_settings, 'getConfirmDelete', -> false

    spy_link = test_bookmarks.spy_link.clone() #Gonna modify it
    destroy_spy = sinon.spy()
    spy_link.on 'destroy', destroy_spy

    collection = new Bm.Collections.Bookmarks visited: false
    collection.reset spy_link
    expect(collection.length).toEqual 1, "bookmark not in collection"

    view = new Bm.Views.Bookmark
      model: spy_link
      collection: collection

    html = view.render().el

    remove = ($ html).find 'a.close'
    remove.click()

    expect(destroy_spy.called).toBeTruthy "bookmark didn't get destroyed"
    expect(collection.length).toEqual 0, "bookmark is still in collection"

    stub.reset()

