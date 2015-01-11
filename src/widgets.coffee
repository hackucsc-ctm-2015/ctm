# Context of a simulation (covers initial run and updates)
#
# @output jQuery selector of the output element
# @fn function which includes all the code
class Context

  # Create new context
  constructor: (@output, @fn) ->
    @output.html ''  # clear output
    @widgets = []

  # Invoked both initially and for updates
  ensureWidget: (widgetClass) ->
    if @i == @widgets.length
      # The widget for this invocation has not been created yet, so do it
      widget = new widgetClass()
      @widgets.push widget
      @output.append widget.el # show the html
    @widgets[@i++] # return widget and increment invocation count

  # Run initially or for updates
  # Makes this context be a global variable (for "slider" calls, etc.)
  run: ->
    @i = 0
    App.ctx = this
    try
      @fn()
    finally
      App.ctx = null

# Base class for all the widgets
class Widget

  # Update widget based on arguments and return new value
  update: -> ''
    # Override in subclasses

# A slider
class Slider extends Widget

  constructor: ->
    @el = $ '<input type="range"></input>'
      .on 'change', App.ctx.run.bind App.ctx

  update: (min, max, step) ->
    @el
      .attr 'min', min
      .attr 'max', max
      .attr 'step', step
      .val()

class Label extends Widget

  constructor: ->
    @el = $ '<pre></pre>'

  update: (val) ->
    @el.html String val


window.slider = (min = 0, max = 1.0, step = 0.1) ->
  App.ctx.ensureWidget(Slider).update min, max, step


window.print = (val = '') ->
  App.ctx.ensureWidget(Label).update val


# Run with a given update function fn
window.run = (fn, output = $('#output')) ->
  ctx = new Context output, fn
  ctx.run()
