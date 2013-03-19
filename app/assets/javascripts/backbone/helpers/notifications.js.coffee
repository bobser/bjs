BJS.Helpers.Notifications = {}

BJS.Helpers.Notifications.alert = (alertType, message) ->
  HandlebarsTemplates['backbone/templates/shared/notifications']({
    'alertType': alertType,
    'message': message
  })

BJS.Helpers.Notifications.error = (message) ->
  this.alert('error', message)


BJS.Helpers.Notifications.success = (message) ->
  this.alert('success', message)

Handlebars.registerHelper('notify_error', (msg) ->
  msg = Handlebars.Utils.escapeExpression(msg)
  new Handlebars.SafeString(BJS.Helpers.Notifications.error(msg))
)

Handlebars.registerHelper('notify_success', (msg) ->
  msg = Handlebars.Utils.escapeExpression(msg)
  new Handlebars.SafeString(BJS.Helpers.Notifications.success(msg))
)