package lip.shapes;

import lip.Shape;

class Primitives {
  public static function circle(x: Float, y: Float, r: Float): Shape {
    return function (xx: Float, yy: Float): Float {
      var xdiff = xx - x;
      var ydiff = yy - y;
      return Math.sqrt(xdiff * xdiff + ydiff * ydiff) - r;
    }
  }
}
