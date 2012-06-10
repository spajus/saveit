describe 'Bm.Views.Bookmark', ->

  it 'Should render itself', ->

    view = new Bm.Views.Bookmark
      model: test_bookmarks[0]
    html = view.render().el

    link = ($ html).find 'a.link'
    expect(link.attr 'href').toEqual test_bookmarks[0].get('url'), 'bad url'
    expect(link.text()).toEqual test_bookmarks[0].get('title'), 'bad title'

    icon = ($ html).find 'i'
    expect(icon.hasClass 'icon-globe').toBeTruthy 'no icon'

    date = ($ html).find 'div.date'
    expect(date.text().trim()).toEqual test_bookmarks[0].get('created_at'), 'bad date'

