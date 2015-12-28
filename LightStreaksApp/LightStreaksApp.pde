
LightStreaks streaks;
FileNamer fileNamer;

void setup() {
  size(640, 640, P2D);

  streaks = new LightStreaks(width, height);
  fileNamer = new FileNamer("output/export", "png");
}

void draw() {
  background(0);
  streaks.draw(g);
}

void keyReleased() {
  switch (key) {
    case 'r':
      save(fileNamer.next());
      break;
  }
}

