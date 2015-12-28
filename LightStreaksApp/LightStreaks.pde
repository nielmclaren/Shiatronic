
import java.util.Iterator;

class LightStreaks {
  private final color pink = 0xffcc5efc;
  private final color reddish = 0xffb805c4;

  private int width;
  private int height;

  private ArrayList<LightStreak> streaks;
  private PGraphics canvas;

  private int minStreaks;
  private int maxStreaks;
  private float streakProbability;
  private float velocity;
  private float streakStartZ;
  private float streakEndZ;

  LightStreaks(int w, int h) {
    width = w;
    height = h;

    streaks = new ArrayList<LightStreak>();
    canvas = createGraphics(w, h, P3D);

    minStreaks = 10;
    maxStreaks = 20;
    streakProbability = 0.05;
    velocity = 4;
    streakStartZ = -1000;
    streakEndZ = 500;

    initStreaks();
  }

  void draw(PGraphics g) {
    updateStreaks();

    canvas.beginDraw();
    canvas.pushMatrix();
    canvas.pushStyle();

    canvas.background(0);

    canvas.noFill();
    canvas.strokeWeight(8);

    drawStreaks(canvas);

    canvas.popStyle();
    canvas.popMatrix();
    canvas.endDraw();

    g.image(canvas, 0, 0);
  }

  private void initStreaks() {
    while (streaks.size() < minStreaks) {
      streaks.add(createStreak(true));
    }
  }

  private void updateStreaks() {
    if (streaks.size() < maxStreaks && random(1) < streakProbability) {
      streaks.add(createStreak());
    }

    for (int i = 0; i < streaks.size(); i++) {
      LightStreak streak = streaks.get(i);
      step(streak);

      if (!isVisible(streak)) {
        println("Remove streak");
        streaks.remove(i);
        i--;
      }
    }
  }

  private LightStreak createStreak() {
    return createStreak(false);
  }

  private LightStreak createStreak(boolean isInit) {
    float streakLength = random(50, 500);

    float minRadius = 0.2 * min(width, height);
    float maxRadius = 0.6 * max(width, height);
    float z;
    if (isInit) {
      z = random(streakStartZ, streakEndZ);
    }
    else {
      z = streakStartZ - streakLength;
    }

    PVector startPoint = new PVector(random(minRadius, maxRadius), 0, z);
    startPoint.rotate(random(2 * PI));
    startPoint.add(width/2, height/2, 0);

    println("Create streak", startPoint, streakLength);

    return new LightStreak(startPoint, streakLength);
  }

  private boolean isVisible(LightStreak streak) {
    return streak.z() < streakEndZ;
  }

  private void step(LightStreak streak) {
    streak.z(streak.z() + velocity);
  }

  private void drawStreaks(PGraphics g) {
    Iterator<LightStreak> iter = streaks.iterator();
    while (iter.hasNext()) {
      LightStreak streak = iter.next();
      streak.draw(g);
    }
  }

  private class LightStreak {
    private PVector point;
    private float length;

    LightStreak(PVector p, float len) {
      point = p;
      length = len;
    }

    float z() {
      return point.z;
    }

    LightStreak z(float v) {
      point.z = v;
      return this;
    }

    void draw(PGraphics g) {
      g.beginDraw();
      g.pushStyle();

      g.noFill();
      g.stroke(0xffff0000);
      g.strokeWeight(6);

      g.line(point.x, point.y, point.z, point.x, point.y, point.z + length);

      g.popStyle();
      g.endDraw();
    }
  }
}

