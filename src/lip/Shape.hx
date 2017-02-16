package lip;

import lip.shapes.Boolean;

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
}

typedef ShapeF = Float -> Float -> Float;
