describe 'Bm.Views.TagBar', ->

  beforeEach ->
    ($ '#container').append $ '<div id="tag-bar"></div>'
  afterEach ->
    ($ '#container').empty()

  it 'Should render itself when empty', ->
    tag_collection = new Bm.Collections.Tags()
    tag_bar = new Bm.Views.TagBar
      collection: tag_collection
    html = tag_bar.render().el

    expect(($ html).length > 0).toBeTruthy "Empty tag bar not rendered"
    expect((($ html).find 'thead tr th').html().match /Tags/)
      .toBeTruthy "Empty tag bar title not rendered"
    expect((($ html).find '.add-tag-zone').length)
      .toEqual 1, "Empty tag bar drop zone not found"

  it 'Should render itself when there are tags', ->
    tag_collection = new Bm.Collections.Tags()
    tag_collection.reset generate_tags 10
    tag_bar = new Bm.Views.TagBar
      collection: tag_collection
    html = tag_bar.render().el

    expect(($ html).length > 0).toBeTruthy "Tag bar not rendered"
    expect((($ html).find 'thead tr th').html().match /Tags/)
      .toBeTruthy "Tag bar title not rendered"
    expect((($ html).find '.add-tag-zone').length)
      .toEqual 1, "Tag bar drop zone not found"
    expect((($ html).find 'tr.tag').length)
      .toEqual 10, "Tags not rendered"

  it 'Should render condensed tags when there are many of them', ->
    tag_collection = new Bm.Collections.Tags()
    tag_collection.reset generate_tags 50
    tag_bar = new Bm.Views.TagBar
      collection: tag_collection
    html = tag_bar.render().el

    expect((($ html).find 'table.table-condensed').length)
      .toEqual 1, "Large amount of tags, but they were not condensed"

