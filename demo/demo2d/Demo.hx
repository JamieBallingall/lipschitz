import thx.color.Rgbxa;
import thx.color.Hsl;

class Demo {
  static var unknown  = Rgbxa.create(0, 0, 0, 0);
  static var interior = Rgbxa.create(0, 0, 0, 1);
  static var exterior = Rgbxa.create(1, 1, 1, 1);

  public static function main() {
    var grid = new lip.Grid(400, 400);
    grid.paintCircle(180, 120, 80);
    MiniCanvas.create(grid.cols, grid.rows)
      .checkboard()
      .box(function(x, y): Rgbxa {
        return switch grid.getAt(Std.int(y * grid.rows), Std.int(x * grid.cols)) {
          case Unknown: unknown;
          case Interior(_): interior;
          case Exterior(_): exterior;
        };
      }).display("draw grid");
  }
}
