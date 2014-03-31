###
 * SwipeView Plugin
 * Conversion to CoffeeScript from source:
 * https://gist.github.com/chelmerich/4087656#file-swipeview-plugin-js
###
(($) ->
  SWIPEVIEW = null
  _defaults = 
    loop: false
    data: []
    renderer: (data) -> data 
    callback: ->
  
  swipeview_init = (config) ->
    $this = this
    _config = $.extend _defaults, config
    _count = _config.data.length
    _cache = []
    flip_handler = ->
      for i in [0...3] 
        MP = SWIPEVIEW.masterPages[i]
        upcoming_index = MP.dataset.upcomingPageIndex
        # If masterPage's data is stale
        if upcoming_index isnt MP.dataset.pageIndex
          rendered_slide = _cache[upcoming_index]
          unless rendered_slide
            rendered_slide = _cache[upcoming_index] = render _config.data[upcoming_index]

          $(MP).html rendered_slide
      _config.callback.call $this, SWIPEVIEW
      return

    init = ->
      ###
      Initialize each slide from render function and data.
      SwipeView has three slides that are continually updated with
      the previous, current, and next slide.
      ###
      init_config = 
        numberOfPages: _count
        loop: _config.loop
      # Get intialized SwipeView instance
      SWIPEVIEW = new SwipeView $this.get(0), init_config
      # $MP = 
      # Initialize first three slides
      for idx in [0, 1, _count-1]
        # Render and cache slide
        _cache[idx] = _config.render _config.data[idx]
        # Append to SwipeView DOM
        $(SWIPEVIEW.masterPages[idx]).append _cache[idx]
      # Attach handler
      SWIPEVIEW.onFlip flip_handler
      return

    # END var 
    if not SwipeView or _count < 3
      return true
    else 
      init()
    # Return wrapper with SwipeView object exposed
    # But maybe unnecessary if exposed already as a global
    return $this.data 'swipeview', SWIPEVIEW

  # Expose plugin
  $.fn.swipeviewInit = swipeview_init
  return
)(jQuery)  