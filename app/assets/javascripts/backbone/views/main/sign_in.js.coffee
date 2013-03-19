BJS.Views.Main = BJS.Views.Main || {}

BJS.Views.Main.SignIn = Backbone.Marionette.ItemView.extend
  template: 'main/sign_in',

  events: {
    'submit form': 'login'
  }

  initialize: ->
    this.model = new BJS.Models.UserSession()
    this.modelBinder = new Backbone.ModelBinder()

  onRender: ->
    this.modelBinder.bind(this.model, this.el)

  login: (e) ->

    self = this
    el = $(this.el)

    e.preventDefault()

    el.find('input.btn-primary').button('loading')
    el.find('.alert-error').remove()

    this.model.save(this.model.attributes, {
      success: (userSession, response) ->
        el.find('input.btn-primary').button('reset')
        BJS.currentUser = new BJS.Models.User(response)
        BJS.vent.trigger("authentication")
      error: (userSession, response) ->
        result = $.parseJSON(response.responseText)
        el.find('form').prepend(BJS.Helpers.Notifications.error(result.error))
        el.find('input.btn-primary').button('reset')
    })



