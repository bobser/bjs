Backbone.Marionette.Renderer.render = (template, data) ->
  HandlebarsTemplates['backbone/templates/' + template](data)
