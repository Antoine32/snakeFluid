final int X = int(16.0 * (16.0 / 9.0));
final int Y = 16;

int point = 0;
float rad = 1;
float speed = 0.25;
float turn = 0;
PVector buf = new PVector(0, 0);
PVector move = buf.copy();
IVector head = new IVector(int(X / 2) - 1, int(Y / 2) - 1);
ArrayList<PVector> fluid = new ArrayList<PVector>();
ArrayList<IVector> pos = new ArrayList<IVector>();
color colHead = color(0, 255, 0);
color colBody = color(0, 200, 0);
boolean alive = false;
IVector apple = new IVector(int(random(0, X - 1)), int(random(0, Y - 1)));
float scale = 0;

void setup() {
  fullScreen(P2D);
  rad = float(width) / float(X);
  pos.add(head);
  fluid.add(new PVector(0, 0));

  scale = width / 33;

  apple.x = -1; 
  apple.y = -1;

  noCursor();
}

void draw() {
  background(0);

  translate(rad / 2.0, rad / 2.0);

  if (true) {
    fill(20);
    for (int x = 0; x < X; x++) {
      for (int y = 0; y < Y; y++) {
        circle(x * rad, y * rad, rad);
      }
    }
  }

  fill(255, 0, 0);
  circle(apple.x * rad, apple.y * rad, rad);

  if (alive) {
    if (abs(fluid.get(0).x) >= 1 & (constrain(head.x + abs(move.x) / move.x, 0, X - 1) != head.x & move.x != 0 || constrain(head.y + abs(move.y) / move.y, 0, Y - 1) != head.y & move.y != 0) || abs(fluid.get(0).y) >= 1 & (constrain(head.x + abs(move.x) / move.x, 0, X - 1) != head.x & move.x != 0 || constrain(head.y + abs(move.y) / move.y, 0, Y - 1) != head.y & move.y != 0)) {
      for (int i = pos.size() - 1; i > 0; i--) {
        pos.get(i).x = pos.get(i - 1).x;
        pos.get(i).y = pos.get(i - 1).y;

        fluid.get(i).x = 0;
        fluid.get(i).y = 0;
      }

      fluid.get(0).x = 0;
      fluid.get(0).y = 0;

      if (move.x != 0) {
        head.x = int(constrain(head.x + abs(move.x) / move.x, 0, X - 1));
      }
      if (move.y != 0) {
        head.y = int(constrain(head.y + abs(move.y) / move.y, 0, Y - 1));
      }

      for (int i = pos.size() - 1; i > 0; i--) {
        if (head.x == pos.get(i).x & head.y == pos.get(i).y) {
          alive = false;
          colHead = color(255, 0, 0);
          colBody = color(200, 0, 0);
        }
      }

      if (head.x == apple.x & head.y == apple.y) {
        boolean can = false;
        do {
          can = false;
          apple.random2D(0, X - 1, 0, Y - 1);
          for (int i = 0; i < pos.size(); i++) {
            if (apple.x == pos.get(i).x & apple.y == pos.get(i).y) {
              can = true;
              break;
            }
          }
        } while (can);
        point++;
        println(point);
        pos.add(new IVector(pos.get(pos.size() - 1).x, pos.get(pos.size() - 1).y));
        fluid.add(new PVector(0, 0));
      }

      move = buf.copy();
    } else if (constrain(head.x + abs(move.x) / move.x, 0, X - 1) != head.x & move.x != 0 || constrain(head.y + abs(move.y) / move.y, 0, Y - 1) != head.y & move.y != 0) {
      fluid.get(0).add(move);

      for (int i = 1; i < fluid.size(); i++) {
        float x = 0;
        if (pos.get(i - 1).x - pos.get(i).x != 0) {
          x = abs(pos.get(i - 1).x - pos.get(i).x) / (pos.get(i - 1).x - pos.get(i).x) * speed;
        }
        float y = 0;
        if (pos.get(i - 1).y - pos.get(i).y != 0) {
          y = abs(pos.get(i - 1).y - pos.get(i).y) / (pos.get(i - 1).y - pos.get(i).y) * speed;
        }
        fluid.get(i).add(constrain(x, -1, 1), constrain(y, -1, 1));
      }
    } else if (alive & move.x != 0 || alive & move.y != 0) {
      alive = false;
      colHead = color(255, 0, 0);
      colBody = color(200, 0, 0);
    }
  }

  fill(colHead);
  circle((head.x + fluid.get(0).x) * rad, (head.y + fluid.get(0).y) * rad, rad);

  fill(colBody);
  for (int i = 1; i < pos.size(); i++) {
    circle((pos.get(i).x + fluid.get(i).x) * rad, (pos.get(i).y + fluid.get(i).y) * rad, rad);
  }

  fill(255);
  textSize(scale);
  String pointS = str(point);
  text(pointS, (pointS.length() / 2) * scale, scale / 2);

  turn += speed;
}

void keyPressed() {
  if (keyCode == UP & move.y <= 0 || keyCode == UP & pos.size() == 1) {
    buf.x = 0;
    buf.y = -speed;
  } else if (keyCode == RIGHT & move.x >= 0 || keyCode == RIGHT & pos.size() == 1) {
    buf.x = speed;
    buf.y = 0;
  } else if (keyCode == DOWN & move.y >= 0 || keyCode == DOWN & pos.size() == 1) {
    buf.x = 0;
    buf.y = speed;
  } else if (keyCode == LEFT& move.x <= 0 || keyCode == LEFT & pos.size() == 1) {
    buf.x = -speed;
    buf.y = 0;
  }

  if (!alive) {
    newGame();
  }

  if (key == 'r') {
    buf.x = 0;
    buf.y = 0;

    newGame();
  }
}

void newGame() {
  colHead = color(0, 255, 0);
  colBody = color(0, 200, 0);
  alive = true;
  head.x = int(X / 2) - 1;
  head.y = int(Y / 2) - 1;
  point = 0;

  pos.clear();
  fluid.clear();

  pos.add(head);
  fluid.add(new PVector(0, 0));

  move = buf.copy();

  boolean can = false;
  do {
    can = false;
    apple.random2D(0, X - 1, 0, Y - 1);
    for (int i = 0; i < pos.size(); i++) {
      if (apple.x == pos.get(i).x & apple.y == pos.get(i).y) {
        can = true;
        break;
      }
    }
  } while (can);
}
