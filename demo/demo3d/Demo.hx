import thx.color.Rgbxa;
import thx.color.Hsl;
import lip.shapes.Primitives;
import lip.shapes.Boolean;

class Demo {
  static var unknown  = Rgbxa.create(0, 0, 0, 0);
  static var interior = Rgbxa.create(0, 0, 0, 1);
  static var exterior = Rgbxa.create(1, 1, 1, 1);
  static var border   = Rgbxa.create(0.65, 0.65, 0.65, 1);

  public static function main() {
    var grid = new lip.Grid3(20, 20, 20);
    var shape = Boolean.union3(Primitives.sphere(8, 8, 10, 6),
                               Primitives.sphere(12, 12, 10, 6));
    grid.render(shape);
    MiniCanvas.create(grid.cols, grid.rows)
      .grid()
      .border(1, border)
      .box(function(x, y): Rgbxa {
        return switch grid.getAt(Std.int(y * grid.rows), Std.int(x * grid.cols), 10) {
          case Unknown: unknown;
          case Interior(_): interior;
          case Exterior(_): exterior;
        };
      }).display("draw grid");
  }
}
