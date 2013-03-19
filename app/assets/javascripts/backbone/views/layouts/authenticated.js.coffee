BJS.Views.Layouts.Authenticated = Backbone.Marionette.Layout.extend({
  template: 'layouts/authenticated',
  regions: {
    tabContent: '#tab-content'
  },

  views: {},

  events: {
    'click ul.nav-tabs li a': 'switchViews'
  },

  onShow: ->
    this.views.login = BJS.Views.Authenticated.Login
    this.views.signup = BJS.Views.Authenticated.Signup
    this.views.retrievePassword = BJS.Views.Authenticated.RetrievePassword
    this.tabContent.show(new this.views.login)
 
  switchViews: (e) -> 
    e.preventDefault()
    this.tabContent.show(new this.views[$(e.target).data('content')])
  

})

BJS.addInitializer ->
  BJS.layouts.Authenticated = new BJS.Views.Layouts.Authenticated()
