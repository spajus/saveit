xml.instruct!
xml.OpenSearchDescription(:xmlns => 'http://a9.com/-/spec/opensearch/1.1/', 'xmlns:moz' => 'http://www.mozilla.org/2006/browser/search/') do
  xml.ShortName("Search saveit.in")
  xml.InputEncoding('UTF-8')
  xml.Description("Search within your saveit.in bookmarks")
  xml.Contact("crew@saveit.in")
  xml.Image(full_url('/favicon.ico'), height: 16, width: 16, type: 'image/ico')
  # escape route helper or else it escapes the '{' '}' characters. then search doesn't work
  xml.Url(type: 'text/html', method: 'get', template: CGI::unescape(full_url('/search/{searchTerms}')))
  xml.moz(:SearchForm, root_url)
end
