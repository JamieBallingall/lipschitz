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
  public static function halfplane(a: Float, b: Float, c: Float): Shape {
    var k = 1 / Math.sqrt(a * a + b * b);
    return function (xx: Float, yy: Float): Float {
      return k * (a * xx + b * yy + c);
    }
  }

  public static function sphere(x: Float, y: Float, z: Float, r: Float): Shape3 {
    return function (xx: Float, yy: Float, zz: Float): Float {
      var xdiff = xx - x;
      var ydiff = yy - y;
      var zdiff = zz - z;
      return Math.sqrt(xdiff * xdiff + ydiff * ydiff + zdiff * zdiff) - r;
    }
  }
}
