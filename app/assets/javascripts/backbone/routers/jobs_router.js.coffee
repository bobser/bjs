class BJS.Routers.JobsRouter extends Backbone.Router
  initialize: (options) ->
    @jobs = new BJS.Collections.JobsCollection()
    @jobs.fetch(options)
    
  routes:
    "jobs/new"              : "newJob"
    "jobs/index"            : "index"
    "jobs/:id/edit"         : "edit"
    "jobs/:id"              : "show"
    "jobs.*"                : "index"  

  newJob: ->
    @view = new BJS.Views.Jobs.NewView(collection: @jobs)
    $("#content").html(@view.render().el)

  index: ->
    @view = new BJS.Views.Jobs.IndexView(jobs: @jobs)
    $("#content").html(@view.render().el)

  show: (id) ->
    job = @jobs.get(id)

    @view = new BJS.Views.Jobs.ShowView(model: job)
    $("#content").html(@view.render().el)

  edit: (id) ->
    job = @jobs.get(id)

    @view = new BJS.Views.Jobs.EditView(model: job)
    $("#content").html(@view.render().el)
