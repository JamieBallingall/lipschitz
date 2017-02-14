package lip.shapes;

class Boolean {
  public static function union(a: Shape, b: Shape): Shape {
    return function (xx: Float, yy: Float): Float {
      return Math.min(a(xx, yy), b(xx, yy));
    }
  }

  public static function intersection(a: Shape, b: Shape): Shape {
    return function (xx: Float, yy: Float): Float {
      return Math.max(a(xx, yy), b(xx, yy));
    }
  }

  public static function difference(a: Shape, b: Shape): Shape {
    return function (xx: Float, yy: Float): Float {
      return Math.max(a(xx, yy), -b(xx, yy));
    }
  }

  public static function complement(a: Shape): Shape {
    return function (xx: Float, yy: Float): Float {
      return -a(xx, yy);
    }
  }
}
