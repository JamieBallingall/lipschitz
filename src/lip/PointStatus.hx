package lip;

enum PointValue {
  Inferred;
  Evaluated(v : Float);
}

enum PointStatus {
  Unknown;
  Interior(v: PointValue);
  Exterior(v: PointValue);
}
