BJS.Helpers.FormHelpers = {}

BJS.Helpers.FormHelpers.fieldHelp = (message) ->
  HandlebarsTemplates['backbone/templates/shared/form_field_help']({'message': message })
