class BJS.Models.Job extends Backbone.Model
  paramRoot: 'job'

  sync: (method, model, options) ->
    if method=='update' || method=='delete'
      options.url = model.url().replace(/\?page=\d/, '')
    else
      options.url = model.url()
    Backbone.sync(method, model, options)

  toJSON: ->
    attrs = _(this.attributes).clone();
    delete attrs.created_at
    delete attrs.updated_at
    attrs

  date_formatted: (old_date) ->
    m_names = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
    d = new Date(old_date)
    f_date = d.getDate()
    f_month = d.getMonth()
    f_year = d.getFullYear()
    new_date = m_names[f_month] + " " + f_date + ", " +  f_year

  defaults:
    title: ''
    date: new Date()
    category: ''
    location: ''
    job_description: ''
    employer_id: null
    apply_link: ''  

  for_template: ->
    j = this.toJSON()
    j.date_formatted = this.date_formatted(j.date)
    j
  

class BJS.Collections.JobsCollection extends BJS.Collections.PaginatedCollection
  model: BJS.Models.Job
  url: ->
    @baseUrl = '/jobs'
    super

