BJS.Views.Shared = BJS.Views.Shared || {}

BJS.Views.Shared.SearchResults = Backbone.Marionette.ItemView.extend
  
  template: JST["backbone/templates/shared/search_results"]

  render: ->
    $(@el).html(@template(@collection.pageInfo()))
    return this

