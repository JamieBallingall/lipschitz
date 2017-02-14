package lip;

import lip.PointStatus;
using thx.Ints;

class Grid {
  public var rows(default, null): Int;
  public var cols(default, null): Int;
  var length: Int;
  public var array(default, null): Array<PointStatus>;

  public function new(rows: Int, cols: Int) {
    this.rows = rows;
    this.cols = cols;
    this.length = rows * cols;
    this.array = [for (i in 0...length) Unknown];
  }

  public function paintCircle(row: Int, col: Int, radius: Float) {
    var absradius = Math.abs(radius);
    for(x in 0...Math.round(radius)) {
      var dx = x/radius;
      var tx = Math.round(Math.sqrt(1 - dx * dx) * radius);
      for(y in 0...tx) {
        setSymmetrics(row, col, y, x, Interior(Inferred));
      }
    }
    setAt(row, col, absradius == 0 ? Exterior(Evaluated(radius)) : Interior(Evaluated(radius)));
  }

  function setSymmetrics(row: Int, col: Int, drow: Int, dcol: Int, value: PointStatus) {
    switch [drow, dcol] {
      case [0, 0]:
        setAt(row, col, value);
      case [0, dcol]:
        setAt(row, col + dcol, value);
        setAt(row, col - dcol, value);
      case [drow, 0]:
        setAt(row + drow, col, value);
        setAt(row - drow, col, value);
      case [drow, dcol]:
        setAt(row + drow, col + dcol, value);
        setAt(row + drow, col - dcol, value);
        setAt(row - drow, col + dcol, value);
        setAt(row - drow, col - dcol, value);
    }
  }

  public function getAt(row: Int, col: Int): PointStatus {
    return array[rowcol2linear(row, col)];
  }

  public function setAt(row: Int, col: Int, status: PointStatus) {
    if(row < 0 || row >= rows || col < 0 || col >= cols) return;
    array[rowcol2linear(row, col)] = status;
  }

  inline function rowcol2linear(row: Int, col: Int): Int {
    return col * rows + row;
  }
}
