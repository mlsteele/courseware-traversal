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

courseware =
  weeks: [
    name: "Week 1"
    sections: [
      "Lec 1"
      "Lec 2"
      "Q 2"
      "Pset 1"
    ]
  ,
    name: "Week 2"
    sections: [
      "Lec 3"
      "Q 2"
      "Pset 2"
      "Q 3"
    ]
  ,
    name: "Week 3"
    sections: [
      "Q 4"
      "Lec 4"
      "Pset 3"
    ]
  ,
    name: "Week 4"
    sections: [
      "Lec 5"
      "Pset 4"
      "Lec 6"
      "Lec 7"
    ]
  ]

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

for i_w in [0...courseware.weeks.length]
  week = courseware.weeks[i_w]
  WEEK_WIDTH = COURSE_WIDTH / courseware.weeks.length
  week_x = i_w * WEEK_WIDTH

  text = new Kinetic.Text(
    x: week_x
    y: HEIGHT / 2 + 50
    width: WEEK_WIDTH
    text: week.name
    fontSize: 14
    fontFamily: 'Helvetica'
    fill: 'black'
    align: 'center'
  )
  layer.add text

  for i_s in [0...week.sections.length]
    section_name = week.sections[i_s]
    SECTION_WIDTH = WEEK_WIDTH / week.sections.length
    section_x = week_x + i_s * SECTION_WIDTH

    text = new Kinetic.Text(
      x: section_x
      y: HEIGHT / 2 + 20
      width: SECTION_WIDTH
      text: section_name
      fontSize: 12
      fontFamily: 'Helvetica'
      fill: 'black'
      align: 'center'
    )
    layer.add text

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
