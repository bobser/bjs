BJS.Views.Jobs ||= {}

class BJS.Views.Jobs.IndexView extends Backbone.View
  template: JST["backbone/templates/jobs/index"]

  initialize: () ->
    @options.jobs.bind('reset', @render, @)
 
  addAll: () ->
    @options.jobs.each(@addOne, this)

  addOne: (job) ->
    view = new BJS.Views.Jobs.JobView({model : job})
    @$("tbody").append(view.render().el)

  addPager: () ->
    jobs = @options.jobs
    view = new BJS.Views.Shared.SearchResults({collection: jobs})
    @$("table").before(view.render().el)

    view = new BJS.Views.Shared.Pager({collection: jobs})
    @$("table").after(view.render().el)


  render: ->
    $(@el).html(@template(jobs: @options.jobs.toJSON() ))
    @addAll()
    @addPager()    
    @
