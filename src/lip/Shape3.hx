package lip;

import lip.shapes.Boolean;

@:callable
abstract Shape3(Shape3F) from Shape3F to Shape3F {
  @:op(A|B)
  inline public function or(other: Shape3): Shape3
    return Boolean.union3(this, other);

  @:op(A&B)
  inline public function and(other: Shape3): Shape3
    return Boolean.intersection3(this, other);

  @:op(A-B)
  inline public function difference(other: Shape3): Shape3
    return Boolean.difference3(this, other);

  @:op(-A)
  inline public function negate(): Shape3
    return Boolean.complement3(this);
}

typedef Shape3F = Float -> Float -> Float -> Float;
