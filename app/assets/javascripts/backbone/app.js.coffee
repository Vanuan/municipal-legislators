@MuLg = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.addRegions
    headerRegion: "#header-region"

  App.addInitializer ->
    App.module("HeaderApp").start()

  App


@MuLg.module "HeaderApp", (Header, App, Backbone, Marionetter, $, _) ->
  @startWithParent = false

  class Header.View extends Marionette.ItemView
    template: "backbone/templates/header_template"

  class Header.Controller extends Marionette.Controller
    constructor: (options = {}) ->
      @region = options.region
      super options

    initialize: ->
      @view = new Header.View
      @region.show @view

  Header.on "start", ->
    new Header.Controller

      region: App.headerRegion

