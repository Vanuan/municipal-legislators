@MuLg = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.addRegions
    headerRegion: "#header-region"
    footerRegion: "#footer-region"
    mainRegion: "#main-region"

  App.addInitializer ->
    App.module("HeaderApp").start()
    App.module("FooterApp").start()
    App.module("PeopleApp").start()

  App

@MuLg.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
  class Controllers.Base extends Marionette.Controller
    constructor: (options = {}) ->
      @region = options.region
      super options


@MuLg.module "HeaderApp", (Header, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class Header.View extends Marionette.ItemView
    template: "backbone/templates/header_template"

  class Header.Controller extends App.Controllers.Base

    initialize: ->
      @view = new Header.View
      @region.show @view

  Header.on "start", ->
    new Header.Controller
      region: App.headerRegion


@MuLg.module "FooterApp", (Footer, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class Footer.View extends Marionette.ItemView
    template: "backbone/templates/footer_template"

  class Footer.Controller extends App.Controllers.Base

    initialize: ->
      @view = new Footer.View
      @region.show @view

  Footer.on "start", ->
    new Footer.Controller
      region: App.footerRegion


@MuLg.module "PeopleApp", (PeopleApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  class PeopleApp.LayoutView extends Marionette.LayoutView
    template: "backbone/templates/main_layout_template"
    regions:
      titleRegion: "#title-region"
      newRegion: "#new-region"
      panelRegion: "#panel-region"
      peopleRegion: "#people-region"

  class PeopleApp.TitleView extends Marionette.ItemView
    template: "backbone/templates/title_template"

  class PeopleApp.NewView extends Marionette.ItemView
    template: "backbone/templates/new_template"

  class PeopleApp.PanelView extends Marionette.ItemView
    template: "backbone/templates/panel_template"


  class PeopleApp.PeopleView extends Marionette.CompositeView
    template: "backbone/templates/people_template"
    childView: PeopleApp.PersonView
    emptyView: PeopleApp.PeopleEmptyView

  class PeopleApp.PeopleEmptyView extends Marionette.ItemView
    template: "backbone/templates/people_empty"

  class PeopleApp.PersonView extends Marionette.ItemView
    template: "backbone/templates/people_template"

  class PeopleApp.Person extends Backbone.Model

  class PeopleApp.People extends Backbone.Collection
    model: PeopleApp.Person
    url: -> "/people"

  App.reqres.setHandler "people:entities",  ->
    people = new PeopleApp.People
    people.fetch
      reset: true

  class PeopleApp.LayoutController extends App.Controllers.Base

    initialize: ->
      @layoutView = new PeopleApp.LayoutView
      @region.show @layoutView
      @titleView = new PeopleApp.TitleView
      @layoutView.titleRegion.show @titleView
      @newView = new PeopleApp.NewView
      @layoutView.newRegion.show @newView
      @panelView = new PeopleApp.PanelView
      @layoutView.panelRegion.show @panelView

      people = App.request "people:entities"
      App.execute "when:fetched", people, =>
        console.log "fetched"
        @peopleView = new PeopleApp.PeopleView
          collection: people
        @layoutView.peopleRegion.show @peopleView

  PeopleApp.on "start", ->
    new PeopleApp.LayoutController
      region: App.mainRegion


  App.commands.setHandler "when:fetched", (entities, callback) ->
    xhrs = _.chain([entities]).flatten().pluck("_fetch").value()

    $.when(xhrs...).done ->
      callback()
