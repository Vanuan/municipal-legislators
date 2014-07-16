do (Marionette) ->
  _.extend Marionette.Renderer,
    render: (template, data) ->
      jst = JST[template]
      throw "Template #{template} not found!" unless jst
      jst(data)
