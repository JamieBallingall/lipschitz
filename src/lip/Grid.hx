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
    var inferred: PointStatus = (radius <=0 ? Interior(Inferred) : Exterior(Inferred));
    for(x in 0...absradius) {
      var dx = x / absradius;
      var tx = Math.floor(Math.sqrt(1 - dx * dx) * absradius);
      for(y in 0...tx) {
        setSymmetrics(row, col, y, x, inferred);
      }
    }
    setAt(row, col, radius <= 0 ? Interior(Evaluated(-radius)) : Exterior(Evaluated(radius)));

    while (cursor < length && array[cursor] != Unknown)
      cursor++;

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

  inline function linear2col(linear: Int): Int {
    return Math.floor(linear / rows);
  }

  inline function linear2row(linear: Int): Int {
    return linear % rows;
  }

  public function render(shape: Shape): Void {
    var z: Float;
    var row: Int;
    var col: Int;

    while (cursor < length) {
      row = linear2row(cursor);
      col = linear2col(cursor);
      paintCircle(row, col, shape(col, row));
    }
  }

}
