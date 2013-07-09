plantTimeout = (cb, ms) -> setTimeout ms, cb
plantInterval = (cb, ms) -> setInterval ms, cb
choose = (array) -> array[Math.floor(Math.random() * array.length)]
randrange = (min, max) -> Math.random() * (max - min) + min

class CoursePoint
  constructor: (@name) ->

  move: ({x, y}) ->
    @.pos =
      x: x
      y: y

courseware =
  weeks: [
    name: "Week 1"
    course_points: [
      new CoursePoint "Lec 1"
      new CoursePoint "Lec 2"
      new CoursePoint "Q 2"
      new CoursePoint "Pset 1"
    ]
  ,
    name: "Week 2"
    course_points: [
      new CoursePoint "Lec 3"
      new CoursePoint "Q 2"
      new CoursePoint "Pset 2"
      new CoursePoint "Q 3"
    ]
  ,
    name: "Week 3"
    course_points: [
      new CoursePoint "Q 4"
      new CoursePoint "Lec 4"
      new CoursePoint "Pset 3"
    ]
  ,
    name: "Week 4"
    course_points: [
      new CoursePoint "Lec 5"
      new CoursePoint "Pset 4"
      new CoursePoint "Lec 6"
      new CoursePoint "Lec 7"
    ]
  ]

extract_coursepoints = (courseware) ->
  cpoints = []
  for week in courseware.weeks
    for cp in week.course_points
      cpoints.push cp
  cpoints


WIDTH = 1366 #700
HEIGHT = 700 #400

COURSE_WIDTH = WIDTH - 100
COURSE_LINE_Y = HEIGHT / 2 - 100

PADDING = 10
TICK_PADDING = 40

WEEK_RAD = 50

stage = new Kinetic.Stage(
  container: "container"
  width: WIDTH
  height: HEIGHT
)

layer = new Kinetic.Layer()

courseline = new Kinetic.Line(
  points: [PADDING, COURSE_LINE_Y, COURSE_WIDTH - PADDING, COURSE_LINE_Y]
  stroke: "blue"
  strokeWidth: 6
  lineCap: "round"
  lineJoin: "round"
)
layer.add courseline

count = 0
for i_w in [0...courseware.weeks.length]
  week = courseware.weeks[i_w]
  WEEK_WIDTH = COURSE_WIDTH / courseware.weeks.length
  week_x = i_w * WEEK_WIDTH + PADDING
  week_y = HEIGHT / 2 + 50

  text = new Kinetic.Text(
    x: week_x
    y: week_y
    width: WEEK_WIDTH
    text: week.name
    fontSize: 14
    fontFamily: 'Helvetica'
    fill: 'black'
    align: 'center'
  )
  layer.add text

  if count != 0
    line = new Kinetic.Line(
      points: [week_x, week_y - WEEK_RAD, week_x, week_y + WEEK_RAD]
      stroke: "black"
      strokeWidth: 5
      lineCap: "round"
      lineJoin: "round"
    )
    layer.add line

  count += 1

  for i_cp in [0...week.course_points.length]
    coursepoint = week.course_points[i_cp]
    COURSEPOINT_WIDTH = WEEK_WIDTH / week.course_points.length
    course_x = week_x + i_cp * COURSEPOINT_WIDTH

    coursepoint.move
      x: course_x
      y: HEIGHT / 2 + 20

    text = new Kinetic.Text(
      x: coursepoint.pos.x
      y: coursepoint.pos.y
      width: COURSEPOINT_WIDTH
      text: coursepoint.name
      fontSize: 12
      fontFamily: 'Helvetica'
      fill: 'black'
      align: 'center'
    )
    layer.add text

    line = new Kinetic.Line(
      points: [coursepoint.pos.x + TICK_PADDING, COURSE_LINE_Y + 10, coursepoint.pos.x + TICK_PADDING, COURSE_LINE_Y - 10]
      stroke: "blue"
      strokeWidth: 2
      lineCap: "round"
      lineJoin: "round"
    )
    layer.add line


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
  while i < cpoints_all.length - 1
    r = Math.random()
    if r < 0.8
      i += 1
    if r < 0.9
      i += 1
      i += Math.floor(randrange(1, 3))
    else
      i -= Math.floor(randrange(1, 4))

    i = Math.max 0, Math.min i, cpoints_all.length - 1
    cpoints.push cpoints_all[i]

  cpoints


render_course_path = (course_path) ->
  point_from_cp = (cp) ->
    x: cp.pos.x
    y: COURSE_LINE_Y

  original_points = (point_from_cp cp for cp in course_path)

  points = []
  for [a,b], i in _.zip original_points, original_points[1..]
    if b != undefined
      if a.x is b.x
        continue

      avg_x = (a.x + b.x) / 2
      points.push a

      y_offset = if a.x > b.x then 1 else -1
      y_offset *= 30 + Math.random() * 20
      points.push
        x: avg_x
        y: COURSE_LINE_Y + y_offset
      points.push b
    else
      points.push a

  path_spline = new Kinetic.Spline(
    points: points
    stroke: "black"
    # strokeWidth: 0.03
    strokeWidth: 5 * Math.random()
    opacity: 0.5
    lineCap: "round"
    tension: 0.3
  )
  layer.add path_spline

for i in [0...10]
  render_course_path pseudo_random_course_path()

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

# layer.add test_student()
stage.add layer
