BJS.Views.Layouts.Main = Backbone.Marionette.Layout.extend({
  template: 'layouts/main',
  regions: {
    header: '#header'
    content: '#content'
    left_panel: '#left_panel'
    right_panel: '#right_panel'
    footer: '#footer'
  }
  views: {},

  events: {
    "click a#search-form": "search_jobs"
    "click a#sign_in": "sign_in"
    "click a#change_layout_category": "layout_category"
    "click a#change_layout_location": "layout_location"
    "click a#sign_in_back": "main_page"
    "click a[id*='days_back_']" : "search_date"
  }

  search_params: ->
    link = $("a[id*='days_back_'].active")
    if link.length > 0
      days = link.attr('id').replace('days_back_', '')
    else
      days = 0

    if $('#location').length > 0
      search_params = {
        'keywords': $('#keywords').val(),
        'location': $('#location').val(),
        'days': days
      }
    else
      search_params = {
        'keywords': $('#keywords').val(),
        'category': $('#category').val(),
        'days': days
      }

  layout_category: (e) ->
    this.header.show(new BJS.Views.Main.HeaderCategory) 
    e.preventDefault() 

  layout_location: (e) ->
    this.header.show(new BJS.Views.Main.Header) 
    e.preventDefault() 

  search_jobs: (e) ->

    router = new BJS.Routers.JobsRouter({data: $.param(@search_params())})
    router.index()

    e.preventDefault()

  search_date: (e) ->
    link = $(e.currentTarget)
    if link.hasClass('active')
      link.removeClass('active')
    else
      $("a[id*='days_back_']").removeClass('active')
      link.addClass('active')

    router = new BJS.Routers.JobsRouter({data: $.param(@search_params())})
    router.index()

    e.preventDefault()

  onShow: ->
    if BJS.currentUser
      this.views.header = BJS.Views.Main.HeaderSignOut
    else
      this.views.header = BJS.Views.Main.Header

    this.views.left_panel = BJS.Views.Main.LeftPanel
    this.views.right_panel = BJS.Views.Main.RightPanel
    this.views.footer = BJS.Views.Main.Footer
    
    
    this.header.show(new this.views.header)
    this.left_panel.show(new this.views.left_panel)
    this.right_panel.show(new this.views.right_panel)
    this.footer.show(new this.views.footer)

  sign_in: (e) ->
    this.views.header = BJS.Views.Main.HeaderLogin
    this.views.sign_in = BJS.Views.Main.SignIn 

    this.header.show(new this.views.header)
    this.left_panel.show(new BJS.Views.Shared.Empty)
    this.right_panel.show(new BJS.Views.Shared.Empty)
    this.footer.show(new BJS.Views.Shared.Empty)

    this.content.show(new this.views.sign_in)

    e.preventDefault

  main_page: (e) ->
    @onShow()
    e.preventDefault

    router = new BJS.Routers.JobsRouter()
    router.index()

    
})

BJS.addInitializer ->
  BJS.layouts.main = new BJS.Views.Layouts.Main()
