public class IVector {
  int x;
  int y;

  IVector() {
  }

  IVector(int xb, int yb) {
    x = xb;
    y = yb;
  }

  void add(int xb, int xy) {
    x += xb;
    y += xy;
  }

  void add(IVector pos) {
    x += pos.x;
    y += pos.y;
  }

  void add(PVector pos) {
    x += int(pos.x);
    y += int(pos.y);
  }

  void sub(int xb, int xy) {
    x -= xb;
    y -= xy;
  }

  void sub(IVector pos) {
    x -= pos.x;
    y -= pos.y;
  }

  void sub(PVector pos) {
    x -= int(pos.x);
    y -= int(pos.y);
  }

  IVector random2D(int bd) {
    x = int(random(0, bd));
    y = int(random(0, bd));
    return new IVector(x, y);
  }

  IVector random2D(int ac, int bd) {
    x = int(random(ac, bd));
    y = int(random(ac, bd));
    return new IVector(x, y);
  }

  IVector random2D(int a, int b, int c, int d) {
    x = int(random(a, b));
    y = int(random(c, d));
    return new IVector(x, y);
  }
}
