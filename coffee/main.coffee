plantTimeout = (cb, ms) -> setTimeout ms, cb
plantInterval = (cb, ms) -> setInterval ms, cb
choose = (array) -> array[Math.floor(Math.random() * array.length)]

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


WIDTH = 700
HEIGHT = 400

COURSE_WIDTH = WIDTH
COURSE_LINE_Y = HEIGHT / 2 - 100

stage = new Kinetic.Stage(
  container: "container"
  width: WIDTH
  height: HEIGHT
)

layer = new Kinetic.Layer()

courseline = new Kinetic.Line(
  points: [0, COURSE_LINE_Y, WIDTH, COURSE_LINE_Y]
  stroke: "black"
  strokeWidth: 6
  lineCap: "square"
  lineJoin: "square"
)
layer.add courseline

for i_w in [0...courseware.weeks.length]
  week = courseware.weeks[i_w]
  WEEK_WIDTH = COURSE_WIDTH / courseware.weeks.length
  WEEK_RAD = 30
  week_x = i_w * WEEK_WIDTH
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

  line = new Kinetic.Line(
    points: [week_x, week_y - WEEK_RAD, week_x, week_y + WEEK_RAD]
    stroke: "black"
    strokeWidth: 2
    lineCap: "square"
    lineJoin: "square"
  )
  layer.add line

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

render_course_path = (course_path) ->
  point_from_cp = (cp) ->
    x: cp.pos.x
    y: COURSE_LINE_Y - 10

  points = (point_from_cp cp for cp in course_path)

  path_spline = new Kinetic.Spline(
    points: points
    stroke: "black"
    strokeWidth: 1
    lineCap: "round"
    tension: 2
  )
  layer.add path_spline

render_course_path test_course_path()

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
