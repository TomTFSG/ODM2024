import processing.video.*;

Capture capture;
int frameC;
int PARTICLE_COUNT;
int PARTICLE_RATIO = 5;
int IMG_RESIZE =200;
float FORCE = 0.5;
int REPULSION_RADIUS = 20;
int DIFERENCE_LIMIT = 80;
float REPULSION_STRENGTH = 0.15;
int IMG_RESIZED_WIDTH = 300;
int partSize;
PImage img;
PImage frameAnterior;
PImage diferenca;
PImage bg;
color bgColor;
boolean[] moved;


Particle particles[]; //NUMERO DE PARTICULAS TBD
void setup(){
  frameC=0;
  size(516,720);
  newImageLoad();
  bg=loadImage("bg.jpg");
  bg.resize(516,720);
  bgColor=255;
  int selectColor=int(random(3));
  if(selectColor==0){
    bgColor=color(#00E684);
  }
  else if(selectColor==1){
    bgColor=color(#2E30FF);
  }
  else if(selectColor==2){
    bgColor=color(#FF3D3B);
  }
  String [] cameras = Capture.list();
  moved= new boolean[width*height];
  capture = new Capture(this, 258, 360, cameras[0]);
  frameAnterior = new PImage(258, 360);
  diferenca = new PImage(258, 360);
  capture.start();
}

void draw() {
  background(bgColor);
  if (capture.available()) {
    capture.read();
    capture.loadPixels();
    frameAnterior.loadPixels();
    diferenca.loadPixels();
    
    for (int y = 0; y < capture.height; y++) {
      for (int x = 0; x < capture.width; x++) {
        // Calculate the index in the original capture array
        int indexOriginal = x + y * capture.width;

        // Calculate the corresponding indices in the moved array for a doubled-size image
        int index1 = 2 * (x + y * capture.width * 2);
        int index2 = index1 + 1;
        int index3 = index1 + capture.width * 2;
        int index4 = index3 + 1;

        // Check if the pixel has moved
        float fR = capture.pixels[indexOriginal] >> 16 & 0xFF;
        float fG = capture.pixels[indexOriginal] >> 8 & 0xFF;
        float fB = capture.pixels[indexOriginal] & 0xFF;
        float f = map(fR + fG + fB, 0, 765, 0, 255);

        float aR = frameAnterior.pixels[indexOriginal] >> 16 & 0xFF;
        float aG = frameAnterior.pixels[indexOriginal] >> 8 & 0xFF;
        float aB = frameAnterior.pixels[indexOriginal] & 0xFF;
        float a = map(aR + aG + aB, 0, 765, 0, 255);

        float d = f - a; // Calculate difference

        // Update moved array based on movement detection
        if (d > DIFERENCE_LIMIT) {
          diferenca.pixels[indexOriginal] = color(255, 255, 255);
          moved[index1] = true;
          moved[index2] = true;
          moved[index3] = true;
          moved[index4] = true;
        } else {
          diferenca.pixels[indexOriginal] = color(0, 0, 0);
          moved[index1] = false;
          moved[index2] = false;
          moved[index3] = false;
          moved[index4] = false;
        }
      }
    }

   diferenca.updatePixels();
   
   frameAnterior = capture.copy();
   //image(capture, 0, 0);
   //image(diferenca, 0, 0,1280,720);
  }
  //background(0);
  //translate(width/2-img.width/2,height/2-img.height/2);//CENTER IMAGE ON WINDOW
  //PARTICULAS
  for(int i=0;i<PARTICLE_COUNT;i++){
    //println(i);
    particles[i].move();
    
    particles[i].show();
  }
  /*RECORD
  if(frameC<720){
    saveFrame("frames/######.tif");
    frameC++;
  }
  else{
    exit();
  }
  */
}
