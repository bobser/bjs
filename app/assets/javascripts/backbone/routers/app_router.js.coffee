class BJS.Routers.AppRouter extends Backbone.Router
  routes:
    ""        : "jobs"
  jobs: ->
    window.location.hash = "/jobs"