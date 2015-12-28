
import java.util.Iterator;

class LightStreaks {
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

  private Palette palette;

  private FastBlurrer blurrer;

  LightStreaks(int w, int h) {
    width = w;
    height = h;

    streaks = new ArrayList<LightStreak>();
    canvas = createGraphics(w, h, P3D);

    minStreaks = 20;
    maxStreaks = 50;
    streakProbability = 0.5;
    velocity = 25;
    streakStartZ = -1000;
    streakEndZ = 500;

    palette = createPalette();

    blurrer = new FastBlurrer(width, height, 2);

    initStreaks();
  }

  void draw(PGraphics g) {
    updateStreaks();

    canvas.beginDraw();
    canvas.pushMatrix();
    canvas.pushStyle();

    canvas.background(0);
    canvas.blendMode(ADD);

    drawStreaks(canvas);

    canvas.popStyle();
    canvas.popMatrix();
    canvas.endDraw();

    canvas.loadPixels();
    blurrer.blur(canvas.pixels, 3);
    canvas.updatePixels();

    g.image(canvas, 0, 0);
  }

  private Palette createPalette() {
    Palette p = new Palette();
    p.add(0xffcc5efc, 2);
    p.add(0xffb805c4, 2);
    p.add(0xff8d0c4d);
    return p;
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

    color c = palette.random();

    PVector startPoint = new PVector(random(minRadius, maxRadius), 0, z);
    startPoint.rotate(random(2 * PI));
    startPoint.add(width/2, height/2, 0);

    return new LightStreak(startPoint, streakLength, c);
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
    private color strokeColor;

    LightStreak(PVector p, float len, color c) {
      point = p;
      length = len;
      strokeColor = c;
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
      g.stroke(strokeColor);
      g.strokeWeight(2);

      drawLine(g, -1, 0);
      drawLine(g, 1, 0);
      drawLine(g, 0, -1);
      drawLine(g, 0, 1);

      drawLine(g, 0, 0);

      g.popStyle();
      g.endDraw();
    }

    private void drawLine(PGraphics g, float xOffset, float yOffset) {
      float offset = 1;
      g.line(
          point.x + xOffset * offset,
          point.y + yOffset * offset,
          point.z,
          point.x + xOffset * offset,
          point.y + yOffset * offset,
          point.z + length);
    }
  }
}

