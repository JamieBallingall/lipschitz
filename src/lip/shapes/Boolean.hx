package lip.shapes;

class Boolean {
  public static function union(a: Shape, b: Shape): Shape {
    return function (xx: Float, yy: Float): Float {
      return Math.min(a(xx, yy), b(xx, yy));
    }
  }
}
