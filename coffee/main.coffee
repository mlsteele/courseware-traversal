plantTimeout = (cb, ms) -> setTimeout ms, cb
plantInterval = (cb, ms) -> setInterval ms, cb

courseware_old = [
  name: 'Pset 1'
  percentage: 0.2
,
  name: 'Pset 2'
  percentage: 0.4
,
  name: 'Pset 3'
  percentage: 0.6
]

# courseware =
#   weeks: [
#     name: "Week n"
#     sections: [
#       "Lec 1"
#       "Lec 2"
#       "Q 2"
#       "Pset 1"
#     ]
#   ,
#     name: "Week n"
#     sections: [
#       "Lec 3"
#       "Q 2"
#       "Pset 2"
#       "Q 3"
#     ]
#   ,
#     name: "Week n"
#     sections: [
#       "Q 4"
#       "Lec 4"
#       "Pset 3"
#     ","
#   ]
#     name: "Week n"
#     sections: [
#       "Lec 5"
#       "Pset 4"
#       "Lec 6"
#       "Lec 7"
#     ]
#   ]

WIDTH = 700
HEIGHT = 400

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

for coursepoint in courseware_old
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

plantTimeout 200, ->
  console.log 'appending'
  test_spline.attrs.points.push
    x: 100
    y: 40
  layer.draw()
