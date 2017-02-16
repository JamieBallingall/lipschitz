import thx.color.Rgbxa;
import lip.shapes.Primitives.*;
import lip.Shape;

class Demo {
  static var unknown  = Rgbxa.create(0, 0, 0, 0);
  static var interior = Rgbxa.create(0, 0, 0, 1);
  static var exterior = Rgbxa.create(1, 1, 1, 0.5);
  static var border   = Rgbxa.create(0.65, 0.65, 0.65, 1);

  public static function main() {
    var grid = new lip.Grid(500, 500);
    var shape = circle(40, 40, 25) & halfplane(1, 1, -90) - circle(40, 40, 10);
    grid.render(shape.scale(2, 1.5) | shape.translate(100, 10));
    MiniCanvas.create(grid.cols, grid.rows)
      .grid()
      .border(1, border)
      .box(function(x, y): Rgbxa {
        return switch grid.getAt(Std.int(y * grid.rows), Std.int(x * grid.cols)) {
          case Unknown: unknown;
          case Interior(_): interior;
          case Exterior(_): exterior;
        };
      }).display("draw grid");
  }
}
