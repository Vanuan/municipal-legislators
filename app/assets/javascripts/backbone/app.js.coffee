@MuLg = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.addRegions
    headerRegion: "#header-region"
    footerRegion: "#footer-region"

  App.addInitializer ->
    App.module("HeaderApp").start()
    App.module("FooterApp").start()

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


@MuLg.module "FooterApp", (Footer, App, Backbone, Marionetter, $, _) ->
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

