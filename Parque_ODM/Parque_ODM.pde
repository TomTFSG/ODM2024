int w, h;
int cols, rows;
BackgroundCell[][] backgroundGrid;
Cell[][] objectGrid;
Ground g;
Sky s;
color branco, ceu, verde;
float dial;
Cloud[] nuvem;
Tree tree;
TopRow topRow;
Grass[] erva;

void setup() {
  size(1800, 720);
  w = 20;
  h = 10;
  dial=0;
  cols = width / w;
  rows = height / h;
  verde=color(#97955B);
  ceu=color(#ACBBD3);
  frameRate(10);
  topRow = new TopRow(cols);

  g=new Ground(verde);
  s=new Sky(ceu);
  backgroundGrid = new BackgroundCell[cols][rows];
  objectGrid= new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      backgroundGrid[i][j] = new BackgroundCell(i*w, j*h, w, h, color(#FFFFFF));
      objectGrid[i][j]=new Cell(i*w, j*h, w, h, color(255, 0));
    }
  }
  tree=new Tree(rows-4,21);
  nuvem=new Cloud[1];
  for (int i=0; i<nuvem.length; i++) {
    nuvem[i]=new Cloud(int(random(0, rows)), int(random(1, 10)), color(#FFFFFF));
  }
  erva=new Grass[18];
  for (int i=0; i<erva.length; i++) {
    int r=int(random(10));
    if(r<2){
      PImage[] florImg=new PImage[2];
      for(int k=0;k<florImg.length;k++){
        florImg[k]=loadImage("flower_"+k+".png");
      }
      erva[i]=new Grass(i,florImg);
    }
    else{
      PImage[] ervaImg=new PImage[5];
      for(int k=0;k<ervaImg.length;k++){
        ervaImg[k]=loadImage("grass_"+k+".png");
      }
      erva[i]=new Grass(i,ervaImg);
    }
  }
}

void draw() {
  background(255);
  corCheck();
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      objectGrid[i][j].clear();
    }
  }
  tree.draw();
  for (int i=0; i<nuvem.length; i++) {
    nuvem[i].move();
  }
  for (int i=0; i<erva.length; i++) {
    erva[i].draw();
  }
  s.drawS();
  g.drawLastRow();
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      backgroundGrid[i][j].draw();
      objectGrid[i][j].draw();
    }
  }
  topRow.draw();
  /*RECORD
  saveFrame("frames/######.tif");
  dial++;
  if(dial==361){
    exit();
  }
  */
}


void keyPressed() {
  if (key=='i') {
    dial++;
    if (dial>360) {
      dial=0;
    }
  }
  if (key=='k') {
    dial--;
    if (dial<0) {
      dial=360;
    }
  }
  if(key=='q'){
    saveFrame("#####.png");
  }
}


void corCheck() {
  println(dial);
  //PRIMAVERA - VERAO
  if (dial>0 && dial<=90) {
    ceu=interpolateColors(azulSp, azulSu, map(dial, 0, 90, 0, 1));
    verde=interpolateColors(verdeSp, verdeSu, map(dial, 0, 90, 0, 1));
  }
  //VERAO - OUTONO
  if (dial>90 && dial<=180) {
    ceu=interpolateColors(azulSu, azulAu, map(dial, 90, 180, 0, 1));
    verde=interpolateColors(verdeSu, verdeAu, map(dial, 90, 180, 0, 1));
  }
  //OUTONO - INVERNO
  if (dial>180 && dial<=270) {
    ceu=interpolateColors(azulAu, azulWi, map(dial, 180, 270, 0, 1));
    verde=interpolateColors(verdeAu, verdeWi, map(dial, 180, 270, 0, 1));
  }
  //INVERNO - PRIMAVERA
  if (dial>270 && dial<=360) {
    ceu=interpolateColors(azulWi, azulSp, map(dial, 270, 360, 0, 1));
    verde=interpolateColors(verdeWi, verdeSp, map(dial, 270, 360, 0, 1));
  }
}
color interpolateColors(color c1, color c2, float amount) {
  float r1 = red(c1);
  float g1 = green(c1);
  float b1 = blue(c1);
  float a1=alpha(c1);

  float r2 = red(c2);
  float g2 = green(c2);
  float b2 = blue(c2);
  float a2=alpha(c2);
  
  float r = map(amount, 0, 1, r1, r2);
  float g = map(amount, 0, 1, g1, g2);
  float b = map(amount, 0, 1, b1, b2);
  float a = map(amount, 0, 1, a1, a2);

  return color(r, g, b,a);
}
