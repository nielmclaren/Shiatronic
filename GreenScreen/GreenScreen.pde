
PImage input;
PImage output;

int numFrames = 1540;

void setup() {
  size(1280, 720, P2D);
  loadAndProcessImage(338);
}

void draw() {
  image(output, 0, 0);
}

void loadAndProcessAllImages() {
  for (int i = 0; i < numFrames; i++) {
    int index = i + 1;
    loadAndProcessImage(index);
    output.save(savePath("data/out/" + getFilename(index)));
  }
}

void loadAndProcessImage() {
  loadAndProcessImage(floor(random(1, 1541)));
}

void loadAndProcessImage(int index) {
  input = loadImage("in/" + getFilename(index));
  output = input.get();
  processPixels(output);
}

void processPixels(PImage img) {
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = processPixel(img.pixels[i]);
  }
  img.updatePixels();
}

color processPixel(color c) {
  if (red(c) < 160 && green(c) > 136 && blue(c) < 192) {
    return color(0, 255, 0);
  }
  else {
    return c;
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
    case 's':
      loadAndProcessAllImages();
      break;
  }
}

void mouseReleased() {
  color c = input.pixels[mouseY * input.width + mouseX];
  println(mouseX + ", " + mouseY + ": " + red(c) + ", " + green(c) + ", " + blue(c));
}