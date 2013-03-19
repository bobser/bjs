BJS.Views.Jobs ||= {}

class BJS.Views.Jobs.NewView extends Backbone.View
  template: JST["backbone/templates/jobs/new"]

  events:
    "submit #new-job": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (job) =>
        @model = job
        router = new BJS.Routers.JobsRouter()
        router.index()

      error: (job, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
