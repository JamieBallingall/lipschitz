import thx.benchmark.measure.Tracker;
import thx.color.Rgbxa;
import thx.format.NumberFormat.unit;
import lip.shapes.Primitives.*;

class Demo {
  static var border   = Rgbxa.create(0.65, 0.65, 0.65, 1);

  public static function main() {
    var grid = new lip.Grid3(80, 80, 40);
    var shape = sphere(20, 20, 20, 18) - sphere(10, 10, 10, 10);
    var step = 1 / grid.layers;
    Tracker.startTimer("render");
    grid.render(shape | shape.translate(40, 40, 0));
    Tracker.stopTimer("render");
    MiniCanvas.create(grid.cols, grid.rows)
      .grid()
      .border(1, border)
      .box(function(x, y): Rgbxa {
        var alpha = 0.0;
        for(i in 0...grid.layers) {
          switch grid.getAt(Std.int(y * grid.rows), Std.int(x * grid.cols), i) {
            case Interior(_):
              alpha += step;
            case _:
          };
        }
        return Rgbxa.create(0, 0, 0, alpha);
      }).display("draw grid: " + unit(Tracker.getTimer("render").elapsed, 2, "ms"));
  }
}
