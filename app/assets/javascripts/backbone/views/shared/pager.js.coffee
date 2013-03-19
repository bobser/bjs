BJS.Views.Shared = BJS.Views.Shared || {}

BJS.Views.Shared.Pager = Backbone.Marionette.ItemView.extend
  
  template: JST["backbone/templates/shared/pager"]

  events: {
    'click li.prev a': 'previous',
    'click li.next a': 'next'
    'click a.page_link': 'paginate'
  }
  
  render: ->
    $(@el).html(@template(@collection.pageInfo()))
    return this

  paginate: (e) ->
    params = BJS.layouts.main.search_params()
    page =  $(e.currentTarget).html()
    @collection.setPage(page, params)
    false
 
  previous: ->
    params = BJS.layouts.main.search_params()
    @collection.previousPage(params)
    false
  
  next: ->
    params = BJS.layouts.main.search_params()
    @collection.nextPage(params)
    false

