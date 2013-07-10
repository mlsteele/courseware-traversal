colorful = true

plantTimeout = (ms, cb) -> setTimeout cb, ms
plantInterval = (ms, cb) -> setInterval cb, ms
choose = (array) -> array[Math.floor(Math.random() * array.length)]
randrange = (min, max) -> Math.random() * (max - min) + min

canvas_arrow = (layer, options) ->
  # headlen is the length of the arrow head
  # points should be an array of 2 points (from, to)
  # options can also include anything a line knows about
  # http://stackoverflow.com/questions/15628838/kinetic-js-drawing-arrowhead-at-start-and-end-of-a-line-using-mouse
  _.defaults options,
    headlen: 10
    stroke: 'black'

  [x1, y1] = [options.points[0].x, options.points[0].y]
  [x2, y2] = [options.points[1].x, options.points[1].y]
  angle = Math.atan2(y2 - y1, x2 - x1)
  headlen = options.headlen

  lines = [
    [x1, y1, x2, y2],
    [x2 - headlen * Math.cos(angle - Math.PI / 6), y2 - headlen * Math.sin(angle - Math.PI / 6), x2, y2],
    [x2, y2, x2 - headlen * Math.cos(angle + Math.PI / 6), y2 - headlen * Math.sin(angle + Math.PI / 6)]
  ]

  for line in lines
    options.points = line
    layer.add new Kinetic.Line options

# WIDTH = 2560
# HEIGHT = 1440
WIDTH = 2560 / 2
HEIGHT = 1440 / 2

COURSE_WIDTH = WIDTH - 100
COURSE_LINE_Y = HEIGHT / 2 - 100

PADDING = WIDTH / 250
TICK_PADDING = WIDTH/34

WEEK_RAD = 50

stage = new Kinetic.Stage(
  container: "container"
  width: WIDTH
  height: HEIGHT
)

layer = new Kinetic.Layer()

title = new Kinetic.Text(
  x: 0
  y: 20
  width: WIDTH - 1.5*TICK_PADDING
  text: "Courseware Traversal"
  fontSize: WIDTH/700 * 15
  fontFamily: 'Helvetica'
  fill: 'black'
  align: 'center'
  )

layer.add title

# courseline = new Kinetic.Line(
#   points: [PADDING, COURSE_LINE_Y, COURSE_WIDTH - PADDING, COURSE_LINE_Y]
#   stroke: "blue"
#   strokeWidth: 6
#   lineCap: "round"
#   lineJoin: "round"
# )
# layer.add courseline

# render courseware titles
# render_coureseware_titles = ->
# count = 0
for i_w in [0...courseware.weeks.length]
  week = courseware.weeks[i_w]
  WEEK_WIDTH = COURSE_WIDTH / courseware.weeks.length
  week_x = i_w * WEEK_WIDTH + PADDING
  week_y = 70*(HEIGHT / 100)

  text = new Kinetic.Text(
    x: week_x
    y: week_y
    width: WEEK_WIDTH
    text: week.name
    fontSize: WIDTH/100
    fontFamily: 'Helvetica'
    fill: 'black'
    align: 'center'
  )
  layer.add text

  # if count != 0
  #   vbar = new Kinetic.Line(
  #     points: [week_x, week_y - WEEK_RAD, week_x, week_y + WEEK_RAD]
  #     stroke: "blue"
  #     strokeWidth: 5
  #     lineCap: "round"
  #     lineJoin: "round"
  #   )
  #   layer.add vbar

  # count += 1

  for i_cp in [0...week.course_points.length]
    coursepoint = week.course_points[i_cp]
    COURSEPOINT_WIDTH = WEEK_WIDTH / week.course_points.length
    course_x = week_x + i_cp * COURSEPOINT_WIDTH

    coursepoint.move
      x: course_x
      y: 65*(HEIGHT / 100)

    text = new Kinetic.Text(
      x: coursepoint.pos.x
      y: coursepoint.pos.y
      width: COURSEPOINT_WIDTH
      text: coursepoint.name
      fontSize: WIDTH/150
      fontFamily: 'Helvetica'
      fill: 'black'
      align: 'center'
    )
    layer.add text

    if colorful
      tickball = new Kinetic.Circle(
        x: coursepoint.pos.x + TICK_PADDING,
        y: COURSE_LINE_Y
        radius: 10
        fill: "white"
        stroke: "black"
        strokeWidth: 3
      )

      layer.add tickball
    else
      tick = new Kinetic.Line(
        points: [coursepoint.pos.x + TICK_PADDING, COURSE_LINE_Y + 10, coursepoint.pos.x + TICK_PADDING, COURSE_LINE_Y - 10]
        stroke: "black"
        strokeWidth: 1
        lineCap: "round"
        lineJoin: "round"
      )
      layer.add tick


# add key arrows
KEY_ARROW_Y_OFFSET = HEIGHT/7
arrow_common_settings =
  opacity: 1
  strokeWidth: 8
  headlen: 32
  lineCap: "round"
  stroke: "#ccc"

canvas_arrow layer, _.defaults {
  points: [
    x: WIDTH / 2
    y: COURSE_LINE_Y - KEY_ARROW_Y_OFFSET
  ,
    x: WIDTH / 2 + 200
    y: COURSE_LINE_Y - KEY_ARROW_Y_OFFSET
  ]}, arrow_common_settings

canvas_arrow layer, _.defaults {
  points: [
    x: WIDTH / 2
    y: COURSE_LINE_Y + KEY_ARROW_Y_OFFSET
  ,
    x: WIDTH / 2 - 200
    y: COURSE_LINE_Y + KEY_ARROW_Y_OFFSET
  ]}, arrow_common_settings


# test_student = ->
#   test_spline = new Kinetic.Spline(
#     points: [
#       x: 0
#       y: HEIGHT / 2 - 100
#     ,
#       x: 100
#       y: HEIGHT / 2 - 23
#     ,
#       x: 200
#       y: HEIGHT / 2 - 10
#     ,
#       x: 330
#       y: HEIGHT / 2 - 70
#     ]
#     stroke: "black"
#     strokeWidth: 1
#     lineCap: "round"
#     tension: 0.5
#   )


test_course_path = ->
  cpoints = []
  for i in [0...5]
    choose extract_coursepoints courseware

pseudo_random_course_path = ->
  cpoints_all = extract_coursepoints courseware
  cpoints = []

  i = 0
  while i < cpoints_all.length
    cpoints.push cpoints_all[i]

    r = Math.random()
    if r < 0.8
      i += 1
    else if r < 0.9
      i += Math.floor(randrange(1, 4))
    else
      i -= Math.floor(randrange(1, 4))

    i = Math.max 0, Math.min i, cpoints_all.length

  cpoints


render_course_path = (course_path, n_students) ->
  point_from_cp = (cp) ->
    x: cp.pos.x + COURSEPOINT_WIDTH / 2
    y: COURSE_LINE_Y

  original_points = (point_from_cp cp for cp in course_path)

  rand_color = -> Math.floor Math.random() * 255
  path_spline = new Kinetic.Spline(
    points: []
    stroke: if colorful then "rgb(#{rand_color()}, #{rand_color()}, #{rand_color()})" else "black"
    # strokeWidth: 0.03
    strokeWidth: if colorful then n_students / 100 * 12 * Math.random() else 3
    opacity: if colorful then 0.4 else 0.1
    lineCap: "round"
    tension: 0.5
  )

  for [a,b], i in _.zip original_points, original_points[1..]
    if b != undefined
      if a.x is b.x
        continue

      path_spline.attrs.points.push a

      # only jump if skipped or going backwards.
      enable_offset_point = false
      if b.x < a.x
        enable_offset_point = true
      if b.x - a.x > COURSEPOINT_WIDTH
        enable_offset_point = true

      if enable_offset_point
        avg_x = (a.x + b.x) / 2
        offset_sign = if a.x > b.x then 1 else -1
        # y_offset_magnitude = (30 + Math.random() * 20)
        y_offset_magnitude = Math.abs(a.x - b.x) / 3
        random_jiggle = Math.random() * 10
        y_offset = offset_sign * y_offset_magnitude
        path_spline.attrs.points.push
          x: avg_x
          y: COURSE_LINE_Y + y_offset + random_jiggle

        # add arrow
        # layer.add canvas_arrow
        #   points: [
        #     x: avg_x
        #     y: COURSE_LINE_Y + y_offset
        #   ,
        #     x: avg_x - offset_sign * 20
        #     y: COURSE_LINE_Y + y_offset
        #   ]
        #   opacity: 0.2
        #   strokeWidth: 1
    else
      path_spline.attrs.points.push a

  plantTimeout Math.random() * 0, ->
    path_spline.setPoints path_spline.attrs.points
    layer.add path_spline

    previous_stroke = undefined
    previous_opacity = undefined

    path_spline.on 'mouseover', ->
      previous_stroke = path_spline.attrs.stroke
      previous_opacity = path_spline.attrs.opacity
      path_spline.moveToTop()

      path_spline.attrs.stroke = if colorful then 'black' else 'red'
      if colorful
        path_spline.attrs.opacity = 0.7
      else
        path_spline.attrs.opacity = 1
      layer.draw()
    path_spline.on 'mouseout', ->
      path_spline.attrs.stroke = previous_stroke
      path_spline.attrs.opacity = previous_opacity
      layer.draw()

    layer.draw()

if colorful
  for i in [0...20]
    render_course_path pseudo_random_course_path(), Math.random() * 100
else
  for i in [0...100]
    render_course_path pseudo_random_course_path(), Math.random() * 100

test_student = ->
  test_spline = new Kinetic.Spline(
    points: [
      x: 0
      y: HEIGHT / 2 - 100
    ,
      x: 100
      y: HEIGHT / 2 - 23
    ,
      x: 200
      y: HEIGHT / 2 - 10
    ,
      x: 330
      y: HEIGHT / 2 - 70
    ]
    stroke: "black"
    strokeWidth: 1
    lineCap: "round"
    tension: 0.5
  )

# test_spline = new Kinetic.Spline(
#   points: [
#     x: 0
#     y: 0
#   ,
#     x: 0
#     y: 0
#   ,
#     x: 1
#     y: 1
#   ]
#   stroke: "black"
#   strokeWidth: 1
#   lineCap: "round"
#   tension: 0.5
# )
# layer.add test_spline

# plantTimeout 500, ->
#   console.log 'foo'
#   # test_spline.attrs.points[1].x = 100
#   test_spline.attrs.points.push
#     x: 100
#     y: 40
#   layer.draw()

# layer.add test_student()
stage.add layer
