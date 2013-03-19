BJS = new Backbone.Marionette.Application()

BJS.Views = {}
BJS.Views.Layouts = {}
BJS.Models = {}
BJS.Collections = {}
BJS.Routers = {}
BJS.Helpers = {}
BJS.Controllers = {}
BJS.layouts = {}

BJS.addRegions({
  main: '#main'
})

BJS.vent.on "authentication", ->
  BJS.main.show(BJS.layouts.main)
  router = new BJS.Routers.JobsRouter()
  router.index()
  try 
    Backbone.history.start()  
  catch err
    Backbone.history.loadUrl()

BJS.bind "initialize:after", ->
  BJS.vent.trigger("authentication")

window.BJS = BJS
 
