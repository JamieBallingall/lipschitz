import utest.UTest;
import utest.Assert;
import lip.Grid3;

class TestAll {
  public function new() {}
  public static function main() {
    UTest.run([new TestAll()]);
  }
  public function testCircle() {
    var c = lip.shapes.Primitives.circle(0, 0, 1);
    Assert.isTrue(c(0, 0) < 0);
    Assert.isTrue(c(10, 10) > 0);
    var cc = lip.shapes.Boolean.union(c, c);
    Assert.isTrue(cc(0, 0) < 0);
    Assert.isTrue(cc(10, 10) > 0);
  }

  public function testIndexing() {
    var grid: Grid3 = new Grid3(3, 5, 7);
    var tests = [
      { linear: 0, row: 0, col:0, layer:0 },
      { linear: 1, row: 1, col:0, layer:0 },
      { linear: 3, row: 0, col:1, layer:0 },
      { linear: 15, row: 0, col:0, layer:1 },
      { linear: 16, row: 1, col:0, layer:1 },
      { linear: 19, row: 1, col:1, layer:1 },
      { linear: 104, row: 2, col:4, layer:6 },
    ];

    for(test in tests) {
      Assert.equals(test.row, grid.linear2row(test.linear), 'expected ${test.row} for row but got ${grid.linear2row(test.linear)}: $test');
      Assert.equals(test.col, grid.linear2col(test.linear), 'expected ${test.col} for col but got ${grid.linear2col(test.linear)}: $test');
      Assert.equals(test.layer, grid.linear2layer(test.linear), 'expected ${test.layer} for layer but got ${grid.linear2layer(test.linear)}: $test');
      Assert.equals(test.linear, grid.rowcollayer2linear(test.row, test.col, test.layer), 'expected ${test.linear} for linear but got ${grid.rowcollayer2linear(test.row, test.col, test.layer)}: $test');
    }
  }
}
