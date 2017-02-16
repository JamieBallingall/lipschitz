import thx.color.Rgbxa;
import lip.shapes.Primitives.*;

class Demo {
  static var unknown  = Rgbxa.create(0, 0, 0, 0);
  static var interior = Rgbxa.create(0, 0, 0, 1);
  static var exterior = Rgbxa.create(1, 1, 1, 0.5);
  static var border   = Rgbxa.create(0.65, 0.65, 0.65, 1);

  public static function main() {
    var grid = new lip.Grid3(40, 40, 20);
    var shape = sphere(8, 8, 10, 6) | sphere(12, 14, 10, 8) - sphere(12, 14, 10, 4) - sphere(16, 18, 8, 6);
    var step = 1 / grid.layers;
    grid.render(shape);
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
      }).display("draw grid");
  }
}
