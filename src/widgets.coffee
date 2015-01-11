# Context of a simulation (covers initial run and updates)
#
# @output jQuery selector of the output element
# @fn function which includes all the code
class Context

  # Create new context
  constructor: (@output, @fn) ->
    @initial = true
    @output.html ''  # clear output
    @widgets = []

  # Invoked both initially and for updates
  ensureWidget: (widgetClass) ->
    if @initial
      # The widget for this invocation has not been created yet, so do it
      widget = new widgetClass()
      @widgets.push widget
      @output.append widget.el # show the html
      @output.append $('<br>') # add line break
    else if @i >= @widgets.length
      throw new Exception 'Number of widgets changed during update'
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
      @initial = false
      if @i != @widgets.length
        throw new Exception 'Number of widgets changed during update'

  setSection: (s) -> @output = s

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
      .on 'mousemove', _.debounce App.ctx.run.bind(App.ctx), 100

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


class List extends Widget

  constructor: ->
    @el = $ '<table class="table table-bordered">
               <tbody><tr></tr></tbody>
             </table>'

  update: (val) ->
    row = @el.find 'tr'
    row.html ''
    for item in val
      $ '<td></td>'
        .html String item
        .appendTo row

window.slider = (min = 0, max = 1.0, step = 0.1) ->
  App.ctx.ensureWidget(Slider).update min, max, step

window.print = (val = '') ->
  App.ctx.ensureWidget(Label).update val

window.list = (val = []) ->
  App.ctx.ensureWidget(List).update val

# Run with a given update function fn
window.run = (fn, output = $('#output')) ->
  ctx = new Context output, fn
  ctx.run()
