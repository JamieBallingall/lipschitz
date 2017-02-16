package lip.shapes;

import lip.Shape;

// TODO this requires proper matrix transformations which I do have in thx.geom
class Transform {
  public static function translate(a: Shape, x: Float, y: Float): Shape {
    return function (xx: Float, yy: Float): Float {
      return a(xx-x, yy-y);
    }
  }

  public static function scale(a: Shape, sx: Float, sy: Float): Shape {
    return function (xx: Float, yy: Float): Float {
      return a(xx/sx, yy/sy);
    }
  }

  public static function translate3(a: Shape3, x: Float, y: Float, z: Float): Shape3 {
    return function (xx: Float, yy: Float, zz: Float): Float {
      return a(xx-x, yy-y, zz-z);
    }
  }

  public static function scale3(a: Shape3, sx: Float, sy: Float, sz: Float): Shape3 {
    return function (xx: Float, yy: Float, zz: Float): Float {
      return a(xx/sx, yy/sy, zz/sz);
    }
  }
}
