
PImage input;
PImage output;

FastBlurrer blurrer;

int numFrames = 1540;

void setup() {
  size(1280, 720, P2D);

  loadAndProcessImage(338);
}

void draw() {
  background(64);
  image(output, 0, 0);
}

void loadAndProcessImage() {
  loadAndProcessImage(floor(random(1, 1541)));
}

void loadAndProcessImage(int index) {
  input = loadImage("in/" + getFilename(index));
  output = input.get();

  blurrer = new FastBlurrer(input.width, input.height, 2);

  processImage(output);
}

void processImage(PImage img) {
  img.format = ARGB;

  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = processPreBlurPixel(img.pixels[i]);
  }

  blurrer.blur(img.pixels);

  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = processPostBlurPixel(img.pixels[i]);
  }
  img.updatePixels();
}

color processPreBlurPixel(color c) {
  if (c == 0xff00ff00) {
    return 0xff000000;
  }
  else {
    return 0xffffffff;
  }
}

color processPostBlurPixel(color c) {
  if (c == 0xff000000 || c == 0xffffffff) {
    return 0x00000000;
  }
  else {
    return 0xffffffff;
  }
}

String getFilename(int index) {
  return "frame" + nf(index, 4) + ".png";
}

void keyReleased() {
  switch (key) {
    case ' ':
      loadAndProcessImage();
      break;
  }
}

void mouseReleased() {
  color c = input.pixels[mouseY * input.width + mouseX];
  println(mouseX + ", " + mouseY + ": " + red(c) + ", " + green(c) + ", " + blue(c));
}
