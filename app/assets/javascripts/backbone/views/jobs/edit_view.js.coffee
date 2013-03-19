BJS.Views.Jobs ||= {}

class BJS.Views.Jobs.EditView extends Backbone.View
  template : JST["backbone/templates/jobs/edit"]

  events :
    "submit #edit-job" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (job) =>
        @model = job
        router = new BJS.Routers.JobsRouter()
        router.index()
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    @$("form").backboneLink(@model)

    return this
