courseware = [
  name: 'Pset 1'
  percentage: 0.2
,
  name: 'Pset 2'
  percentage: 0.4
,
  name: 'Pset 3'
  percentage: 0.6
]

WIDTH = 578
HEIGHT = 200

COURSE_WIDTH = WIDTH

stage = new Kinetic.Stage(
  container: "container"
  width: WIDTH
  height: HEIGHT
)

layer = new Kinetic.Layer()

courseline = new Kinetic.Line(
  points: [0, HEIGHT / 2, WIDTH, HEIGHT / 2]
  stroke: "black"
  strokeWidth: 6
  lineCap: "square"
  lineJoin: "square"
)
layer.add courseline

for coursepoint in courseware
  text = new Kinetic.Text(
    x: COURSE_WIDTH * coursepoint.percentage
    y: HEIGHT / 2 + 10
    text: coursepoint.name
    fontSize: 14
    fontFamily: 'Helvetica'
    fill: 'black'
  )
  layer.add text

  # coursepoint.percentage

test_spline = new Kinetic.Spline(
  points: [
    x: 0
    y: HEIGHT / 2
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
  strokeWidth: 3
  lineCap: "round"
  tension: 0.5
)
layer.add test_spline

stage.add layer
