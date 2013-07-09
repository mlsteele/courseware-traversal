class CoursePoint
  constructor: (@name) ->

  move: ({x, y}) ->
    @.pos =
      x: x
      y: y

extract_coursepoints = (courseware) ->
  cpoints = []
  for week in courseware.weeks
    for cp in week.course_points
      cpoints.push cp
  cpoints

courseware =
  weeks: [
    name: "Week 1"
    course_points: [
      new CoursePoint "Lec 1"
      new CoursePoint "Lec 2"
      new CoursePoint "Pset 1"
      new CoursePoint "Q 1"
    ]
  ,
    name: "Week 2"
    course_points: [
      new CoursePoint "Lec 3"
      new CoursePoint "Lec 4"
      new CoursePoint "Pset 2"
      new CoursePoint "Q 2"
    ]
  ,
    name: "Week 3"
    course_points: [
      new CoursePoint "Lec 5"
      new CoursePoint "Lec 6"
      new CoursePoint "Pset 3"
      new CoursePoint "Q 3"
    ]
  ,
    name: "Week 4"
    course_points: [
      new CoursePoint "Lec 7"
      new CoursePoint "Lec 8"
      new CoursePoint "Pset 4"
      new CoursePoint "Q 4"
    ]
  ]

# courseware_probabilities =
#   courseware.weeks[0].course_points[0]:
#     courseware.weeks[0].course_points[1]: 1
#   courseware.weeks[0].course_points[1]:
#     courseware.weeks[0].course_points[2]: 1
#   courseware.weeks[0].course_points[2]:
#     courseware.weeks[0].course_points[3]: 1
#   courseware.weeks[0].course_points[3]:
#     courseware.weeks[1].course_points[0]: 1

#   courseware.weeks[1].course_points[0]:
#     courseware.weeks[1].course_points[1]: 1
#   courseware.weeks[1].course_points[1]:
#     courseware.weeks[1].course_points[2]: 1
#   courseware.weeks[1].course_points[2]:
#     courseware.weeks[1].course_points[3]: 1
#   courseware.weeks[1].course_points[3]:
#     courseware.weeks[2].course_points[0]: 1

#   courseware.weeks[2].course_points[0]:
#     courseware.weeks[2].course_points[1]: 1
#   courseware.weeks[2].course_points[1]:
#     courseware.weeks[2].course_points[2]: 1
#   courseware.weeks[2].course_points[2]:
#     courseware.weeks[3].course_points[0]: 1

#   courseware.weeks[3].course_points[0]:
#     courseware.weeks[3].course_points[1]: 1
#   courseware.weeks[3].course_points[1]:
#     courseware.weeks[3].course_points[2]: 1
#   courseware.weeks[3].course_points[2]:
#     courseware.weeks[3].course_points[3]: 1


# exports
window.CoursePoint = CoursePoint
window.extract_coursepoints = extract_coursepoints
window.courseware = courseware
