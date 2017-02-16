package lip;

import lip.PointStatus;
using thx.Ints;

class Grid3 {
  public var array(default, null): Array<PointStatus>;
  public var rows(default, null): Int;
  public var cols(default, null): Int;
  public var layers(default, null): Int;

  static var interiorInferred = Interior(Inferred);
  static var exteriorInferred = Exterior(Inferred);

  var length: Int;
  var cursor: Int; // The position of the first Unknown

  public function new(rows: Int, cols: Int, layers: Int) {
    this.rows = rows;
    this.cols = cols;
    this.layers = layers;
    this.length = rows * cols * layers;
    this.array = [for (i in 0...length) Unknown];
    this.cursor = 0;
  }

  public function paintSphere(row: Int, col: Int, layer: Int, radius: Float) {
    var absradius: Int = Math.floor(Math.abs(radius));
    var inferred: PointStatus = radius <= 0 ? interiorInferred : exteriorInferred;
    for(l in (-absradius)...absradius) {
      var dl = l / absradius;
      var tl = Math.floor(Math.sqrt(1 - dl * dl) * absradius);
      for(x in 0...tl) {
        var dx = x / tl;
        var tx = Math.floor(Math.sqrt(1 - dx * dx) * tl);
        for(y in 0...tx) {
          setSymmetrics(row, col, l, y, x, inferred);
        }
      }
    }
    setAt(row, col, layer, radius <= 0 ? Interior(Evaluated(-radius)) : Exterior(Evaluated(radius)));

    while (cursor < length && array[cursor] != Unknown)
      cursor++;
  }

  function setSymmetrics(row: Int, col: Int, layer: Int, drow: Int, dcol: Int, value: PointStatus) {
    if(drow == 0 && dcol == 0) {
      setAt(row, col, layer, value);
    } else if(drow == 0) {
      setAt(row, col + dcol, layer, value);
      setAt(row, col - dcol, layer, value);
    } else if(dcol == 0) {
      setAt(row + drow, col, layer, value);
      setAt(row - drow, col, layer, value);
    } else {
      setAt(row + drow, col + dcol, layer, value);
      setAt(row + drow, col - dcol, layer, value);
      setAt(row - drow, col + dcol, layer, value);
      setAt(row - drow, col - dcol, layer, value);
    }
  }

  public function getAt(row: Int, col: Int, layer: Int): PointStatus {
    return array[rowcollayer2linear(row, col, layer)];
  }

  public function setAt(row: Int, col: Int, layer: Int, status: PointStatus) {
    if(row < 0 || row >= rows || col < 0 || col >= cols || layer < 0 || layer >= layers) return;
    array[rowcollayer2linear(row, col, layer)] = status;
  }

  public inline function rowcollayer2linear(row: Int, col: Int, layer: Int): Int {
    return layer * cols * rows + col * rows + row;
  }

  public inline function linear2layer(linear: Int): Int {
    return Math.floor(linear / (rows * cols));
  }

  public inline function linear2col(linear: Int): Int {
    var temp: Int = linear - rows * cols * linear2layer(linear);
    return Math.floor(temp / rows);
  }

  public inline function linear2row(linear: Int): Int {
    return linear % rows;
  }

  public function render(shape: Shape3): Void {
    var z: Float;
    var row: Int;
    var col: Int;
    var layer: Int;

    while (cursor < length) {
      row = linear2row(cursor);
      col = linear2col(cursor);
      layer = linear2layer(cursor);
      paintSphere(row, col, layer, shape(col, row, layer));
    }
  }
}
