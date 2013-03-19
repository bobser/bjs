class BJS.Collections.PaginatedCollection extends Backbone.Collection
  
  fetch: (options) ->
    options ||= {}
    @trigger "fetching"
    self = this
    success = options.success
    options.success = (resp) ->
      self.trigger "fetched"
      success self, resp  if success

    Backbone.Collection::fetch.call this, options

  parse: (resp) ->
    @page = resp.page
    @perPage = resp.per_page
    @total = resp.total
    resp.items

  url: ->
    @baseUrl + "?" + $.param({page: @page})

  pageInfo: ->
    info =
      total: @total
      page: @page
      perPage: @perPage
      pages: Math.ceil(@total / @perPage)
      prev: false
      next: false

    max = Math.min(@total, @page * @perPage)
    max = @total  if @total is @pages * @perPage
    info.range = [ (@page - 1) * @perPage + 1, max ]
    info.prev = @page - 1  if @page > 1
    info.next = @page + 1  if @page < info.pages
    info

  setPage: (page, params) ->
    @page = page
    this.fetch({data: $.param(params)}) 

  nextPage: (params) ->
    return false  unless @pageInfo().next
    @page = @page + 1
    this.fetch({data: $.param(params)})

  previousPage: (params) ->
    return false  unless @pageInfo().prev
    @page = @page - 1
    this.fetch({data: $.param(params)})