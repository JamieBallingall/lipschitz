import utest.UTest;
import utest.Assert;

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
}
