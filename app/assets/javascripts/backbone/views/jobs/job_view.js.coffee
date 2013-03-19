BJS.Views.Jobs ||= {}

class BJS.Views.Jobs.JobView extends Backbone.View


  template: JST["backbone/templates/jobs/job"]

  events:
    "click .destroy" : "destroy"
    "click a.more_link" : "show_more"
    "click a.less_link" : "show_less"

  tagName: "tr"


  date_formatted: (old_date) ->
    m_names = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")

    d = new Date(old_date)
    f_date = d.getDate()
    f_month = d.getMonth()
    f_year = d.getFullYear()
    new_date = m_names[f_month] + ", " +f_date + " " +  f_year
    alert new_date

  show_more: (e) ->
    less = $(@el).children('td').children('div.less_info')
    more = $(@el).children('td').children('div.more_info')
    less.fadeOut()
    more.fadeIn()
    e.preventDefault()

  show_less: (e) ->
    less = $(@el).children('td').children('div.less_info')
    more = $(@el).children('td').children('div.more_info')
    more.fadeOut()
    less.fadeIn()
    e.preventDefault()

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.for_template() ))
    return this
