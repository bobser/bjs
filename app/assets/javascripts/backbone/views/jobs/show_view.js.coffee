BJS.Views.Jobs ||= {}

class BJS.Views.Jobs.ShowView extends Backbone.View
  template: JST["backbone/templates/jobs/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
