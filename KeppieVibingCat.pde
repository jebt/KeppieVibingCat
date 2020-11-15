import processing.video.*;
Movie catMovie;
Movie backgroundMovie;
PImage pImage;

void setup() {
  frameRate(60);
  //size(1440, 810);
  size(320, 180);
  catMovie = new Movie(this, "..\\Vibing Cat Extended (Green Screen).mp4");
  backgroundMovie = new Movie(this, "..\\videoplayback (1).mp4");
  catMovie.loop();
  backgroundMovie.loop();
}

void draw() {
  background(color(150));
  image(backgroundMovie, 0, 0, width, height);
  pImage = createImage(catMovie.width, catMovie.height, ARGB);
  arrayCopy(catMovie.pixels, pImage.pixels);
  substituteGreen(pImage);
  image(pImage, 0, 0, width, height);
  println("frameCount: " + frameCount);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

void substituteGreen(PImage pImage) {
  int totalNumberOfPixels = pImage.pixels.length;
  for (int i = 0; i < totalNumberOfPixels; i++) {
    int pixel = pImage.pixels[i];
    //int a = (pixel >> 24) & 0xFF;
    int r = (pixel >> 16) & 0xFF;
    int g = (pixel >> 8) & 0xFF;
    int b = pixel & 0xFF;
    if (r < 150 && g > 150 && b < 150) {  // ~green
      pImage.pixels[i] = color(0, 0);
    }
  }
}
