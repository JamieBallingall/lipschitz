package lip;

import lip.PointStatus;

class Grid {
  var rows: Int;
  var cols: Int;
  var length: Int;
  var array: Array<PointStatus>;

  public function new(rows: Int, cols: Int) {
    this.rows = rows;
    this.cols = cols;
    this.length = rows * cols;
    this.array = [for (i in 0...length) Unknown];
  }

  public function paintCircle(row: Int, col: Int, radius: Float) {
    array[rowcol2linear(row, col)] = Interior(Evaluated(radius));
    absradius = Math.abs(radius);
    if (absradius > 0) {
      
    }
  }

  public inline function rowcol2linear(row: Int, col: Int): Int {
    return col * rows + row;
  }

}
