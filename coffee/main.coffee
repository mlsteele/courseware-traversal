console.log 'hello coffeescript main'

`
var stage = new Kinetic.Stage({
  container: 'container',
  width: 578,
  height: 200
});

var layer = new Kinetic.Layer();

var rect = new Kinetic.Rect({
  x: 239,
  y: 75,
  width: 100,
  height: 50,
  fill: 'green',
  stroke: 'black',
  strokeWidth: 4
});

var redLine = new Kinetic.Line({
  points: [73, 70, 340, 23, 450, 60, 500, 20],
  stroke: 'red',
  strokeWidth: 15,
  lineCap: 'round',
  lineJoin: 'round'
});

var redSpline = new Kinetic.Spline({
    points: [{
      x: 73,
      y: 160
    }, {
      x: 340,
      y: 23
    }, {
      x: 500,
      y: 109
    }, {
      x: 300,
      y: 109
    }],
    stroke: 'red',
    strokeWidth: 10,
    lineCap: 'round',
    tension: 0.5
});

layer.add(redLine)
layer.add(redSpline)
// add the shape to the layer
layer.add(rect);

// add the layer to the stage
stage.add(layer);
`
