package lip;

import lip.PointStatus;
using thx.Ints;

class Grid {
  public var array(default, null): Array<PointStatus>;
  public var rows(default, null): Int;
  public var cols(default, null): Int;
  var length: Int;
  var cursor: Int; // The position of the first Unknown

  public function new(rows: Int, cols: Int) {
    this.rows = rows;
    this.cols = cols;
    this.length = rows * cols;
    this.array = [for (i in 0...length) Unknown];
    this.cursor = 0;
  }

  public function paintCircle(row: Int, col: Int, radius: Float) {
    var absradius: Int = Math.floor(Math.abs(radius));
    for(x in 0...absradius) {
      var dx = x / absradius;
      var tx = Math.floor(Math.sqrt(1 - dx * dx) * absradius);
      if(radius <= 0) {
        for(y in 0...tx) {
          setSymmetrics(row, col, y, x, Interior(Inferred));
        }
      }
      else {
        for(y in 0...tx) {
          setSymmetrics(row, col, y, x, Exterior(Inferred));
        }
      }
    }
    setAt(row, col, absradius == 0 ? Exterior(Evaluated(radius)) : Interior(Evaluated(radius)));
    advanceCursor(absradius);
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

  public inline function point2linear(p: Point2): Int {
    return rowcol2linear(p.row, p.col);
  }

  public inline function linear2point(linear: Int): Point2 {
    var col: Int = Math.floor(linear / rows);
    var row: Int = linear % rows;
    return new Point2(row, col);
  }

  function advanceCursor(skip: Int): Void {
    // skip is not used right now. But it will be one day
    while (cursor <= length && array[cursor] != Unknown)
      cursor++;
  }

  public function render(shape: Shape): Void {
    var z: Float;
    var p: Point2;
    while (cursor <= length) {
      p = linear2point(cursor);
      z = shape(p.col, p.row);
      paintCircle(p.row, p.col, z);
    }
  }

}
