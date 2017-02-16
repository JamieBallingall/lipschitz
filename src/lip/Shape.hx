package lip;

import lip.shapes.Boolean;
import lip.shapes.Transform;

@:callable
abstract Shape(ShapeF) from ShapeF to ShapeF {
  @:op(A|B)
  inline public function or(other: Shape): Shape
    return Boolean.union(this, other);

  @:op(A&B)
  inline public function and(other: Shape): Shape
    return Boolean.intersection(this, other);

  @:op(A-B)
  inline public function difference(other: Shape): Shape
    return Boolean.difference(this, other);

  @:op(-A)
  inline public function negate(): Shape
    return Boolean.complement(this);

  inline public function translate(x: Float, y: Float): Shape
    return Transform.translate(this, x, y);

  inline public function scale(sx: Float, sy: Float): Shape
    return Transform.scale(this, sx, sy);
}

typedef ShapeF = Float -> Float -> Float;
