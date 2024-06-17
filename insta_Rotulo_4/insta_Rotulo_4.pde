import processing.video.*;
import milchreis.imageprocessing.*;
//import controlP5.*;

String [] tipos = {"fidel", "amat","present","virtual","proper"};
String [] legendas = {"vi negre", "vi rosa","vi blanc"};

int nImgs = 5;
int timer = 0;
int timerLim = 20;
int numImage = 0;
PImage [] imagensCpaturadas = new PImage[nImgs];
PImage instaImage;
int [] instaDims = {25,25};

int distrib []    = {0,0};
int dimSegMult    = 3;
int dim []        = {int(120*2.5), int(160*2.5)};
int dimCutSize [] = {0,0}; 
int space []      = {45,30};
int spaceHV []    = {0,120};

int ladoMaiorI = 0;

//BLUR 
//kernel
int l = 3;
int c = 3;

int k;
int km, kM; //kernel primeiro ponto, kernel segundo ponto 
int sigma=25;
float scale;
//float[][] kernel = new float [l][c];
ArrayList<Float> kernelX = new ArrayList<>();
ArrayList<Float> kernelY = new ArrayList<>();
int lH,cH = 0;

Capture cam;

PFont T;
PFont L;


Rotulo rotulos [] = new Rotulo [nImgs]; 

void setup(){
  size(1800,900);
  background(0);
  
  //defenir kernell
  defGaussianKernel();
  
  ladoMaiorI = idLadoMaior(dim [0], dim [1]);

  //cria as dimensoes da grelha em funcao de espaco e comprimento das imagens 
  distrib[0] = round((width-space[0])/(dim[0]+space[0]));
  println("N1: " + distrib[0]);
  distrib[1] = round((height-space[1])/(dim[1]+space[1]));
  println("N2: " + distrib[1]);
  
  T = createFont("Roboto-Bold-48.vlw", 128);
  L = createFont("Roboto-Regular-48.vlw", 128);
  
  String[] cameras = Capture.list();
  
  instaImage = loadImage("LoadingIconIsnta_2.png");
  
  if(cameras.length == 0) {
    exit();
  } else {
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
  }
    
    cam = new Capture(this, dim[0]*dimSegMult, dim[1]*dimSegMult,cameras[1]);
    cam.start();     
    //cam.setSize(dim[0]*dimSegMult, dim[1]*dimSegMult);
  }
  
  //INITIALIZR 
  inatializeImage();
}

void draw(){
  background(0);
 
  if (cam.available() == true) {
    cam.read();
  }

  displayImages();
  
  timer = (timer+1)%timerLim;  
}

void inatializeImage(){   
   PImage img  = loadImage("All_Desenhos.jpg");
   img.resize(600,600);
   
   println("loaded Image");
  
   for(int i = 0 ; i<distrib[0]; i++){
     for(int j = 0 ; j<distrib[1]; j++){
       int pos = i + (j* distrib[0]);
       if(pos<nImgs){
         println("Posição image:" + pos);
         float x = i*dim[0] + (i+1)*space[0];
         float y = j*dim[1] + (j+1)*space[1];
         //image(imagensCpaturadas[i + (j* distrib[0])], i*dim[0] + (i+1)*space[0] , j*dim[1] + (j+1)*space[1]); 
         rotulos[pos] = new Rotulo(new PVector(x, y, 0), cam, instaImage);
       }
     }
   } 
   
}

void captureNewImage(){
  
  
  
}

void transformImage(){
  
}

void blurImage(){
  
}

PImage cutImage(PImage imagemInteira){
    PImage img = imagemInteira.get();
    PImage imgr;
    int ladoM = 0;
    float razao = 0;
    int dimI [] = {imagemInteira.width, imagemInteira.height};
    int ladoId  = idLadoMaior(imagemInteira.width, imagemInteira.height);
    
    if(ladoMaiorI == ladoId){
       razao = dimI[ladoId]/dim[ladoId];
    }else{
       if(ladoId == 0){
         ladoId = 1;
       }else{
         ladoId = 0;
       }
       
       razao = dimI[ladoId]/dim[ladoMaiorI];
    }
    
    img.resize(round(dimI[0]/razao), round(dimI[1]/razao));
    int halfW = img.width/2;
    int halfH = img.height/2;
    int acres = round((halfW) - (halfW - kernelX.size()*2));
    int acres1 = round((halfH) - (halfH - kernelY.size()*2));
    imgr = createImage(dim[0],dim[1],RGB);
        
    img.loadPixels();
    imgr.loadPixels();
    
    int aux = img.width;
    
     for(int i = 0 ; i<dim[0]; i++){
       for(int j = 0 ; j<dim[1]; j++){
         int pos1 = i + acres + j * aux;
         int pos  = i + j * dim[0];
           
           imgr.pixels[pos] = img.pixels[pos1];

       }
     } 
     
    imgr.updatePixels();
    img.updatePixels();
    
    return imgr; 
}

int idLadoMaior(int l, int c){
    int ladoId = -1;
    
    if( l > c){
      ladoId = 0;
    }else{
      ladoId = 1;
    }
    
    return ladoId;
}

void displayImages(){ 
   for(int i = 0; i<rotulos.length; i++){
      rotulos[i].display();     
   }
   
   if(timer%timerLim==0){
     rotulos[numImage].updateImageFoto(cam);
     numImage = (numImage+1) % nImgs;
   }
   
   println("N Image:" + numImage);
   println("N Timer:" + timer);
}
