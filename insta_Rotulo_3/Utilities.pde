PImage generateNormalMap(PImage image_) {

  PImage image = image_;
  
  // Loop através de todos os pixels da imagem de altura
  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      
      float dhdx = image.get((x + 1) % (width-1), y) - image.get((x + (width-1)) % (width-1), y);
      float dhdy = image.get(x,(y + 1) % (height-1)) - image.get(x,(y + (height-1)) % (height-1));
      
      float magnitude = sqrt((dhdx * dhdx) + (dhdy * dhdy));
      dhdx /= magnitude;
      dhdy /= magnitude;
      
      int r = round(map(dhdx, -1, 1, 0, 255));
      int g = round(map(dhdy, -1, 1, 0, 255));
      int b = 127; 
      
      image.set(x, y, color(r, g, b));
    }
  }
  
  // Atualiza os pixels na imagem de normais
  image.updatePixels();
  return image;
}



void generateHeightMap(PImage image) {
  // Loop através de todos os pixels da imagem
  image.loadPixels();
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int pos =  x + y * width;
      float intensity = brightness(color(red(image.pixels[pos]),green(image.pixels[pos]),blue(image.pixels[pos])));

      image.set(x, y, color(intensity));
    }
  }
  
  image.updatePixels();
  
  // Atualiza os pixels na imagem de altura
  
}



PImage perlinNoise(int w, int h, float inc){
  PImage noise =  createImage(w,h,RGB);
  
  float tY = 0;
  
  noise.loadPixels();
  
  for(int x=0; x<w ; x++){
      float tX = 0;
      for(int y=0; y<h ; y++){
        int pos = (x + y * w);
        int val = int(noise(tX, tY) * 255);
        
        noise.pixels[pos] = color(val);
        
        tX += inc;
      }
      tY += inc;
  }
  
  noise.updatePixels();
  
  return noise;
}

PImage glassEffect(PImage normal, PImage imagem, int maxRe){
      PImage glass = createImage( normal.width , normal.height , RGB );
      
      glass = normal.copy();
      glass.loadPixels();
  
      for(int x=0; x<normal.width ; x++){
          for(int y=0; y<normal.height ; y++){
            int pos = (x + y * normal.width);
            
            int pixel = glass.pixels[pos];
            
            int red = (pixel >> 16) & 0xFF; 
            int green = (pixel >> 8) & 0xFF;
            
            PVector getPos =  new PVector (
            map(red  ,0,255,1,-1) * maxRe,
            map(green,0,255,1,-1) * maxRe); //Alterar o constrain para um metodo de diminuição de maxRe;
           
            glass.pixels[pos] = imagem.get(int(constrain(x + getPos.x, 0, imagem.width -1)) , int(constrain(y + getPos.y, 0, imagem.height -1)) );
          }
      }
      
      glass.updatePixels();
  
      return glass;
}

PImage gradient (PVector dims, PVector p1, PVector p2, int axis){
  //P1 - ancora 1
  //P2 - ancora 2
  
  p1.x = constrain(p1.x,0,1);
  p2.x = constrain(p2.x,0,1);
  
  p1.y = constrain(p1.x,0,1);
  p2.y = constrain(p2.x,0,1);
  
  PImage gradient = createImage(int(dims.x), int(dims.y), RGB);
   
  noFill();
  
  gradient.loadPixels();
  
   if(axis == 0){//eixos Y
     for(int i = 0; i<dims.y; i++)
     {
         float steps = i/dims.y;
         //float x = bezierPoint(0, p1.x, p2.x, 0, steps); //return 0 a 1
         float y = bezierPoint(0, p1.y, p2.y, 1, steps);   // return 0 a 1
         
         for(int j = 0; j<dims.x; j++)
         {
            int pos = (j + i * int(dims.x));
            gradient.pixels[pos] = color(0,map(y,0,1,0,255),127);
         }
     }
     gradient.updatePixels();
   }
   
   else if(axis == 1){//eixos X 
         for(int i = 0; i<dims.x; i++)
         {
           float steps = i/dims.x;
           //float x = bezierPoint(0, p1.x, p2.x, 0, steps); //return 0 a 1
           float y = bezierPoint(0, p1.y, p2.y, 1, steps); // return -1 a 1
           
               for(int j = 0; j<dims.y; j++)
               {
                  int pos = (i + j * int(dims.x));
                  gradient.pixels[pos] = color(map(y,0,1,0,255),127,127);
               }
         }
     gradient.updatePixels();
   }
   else{//ambos os Eixos    
   }
   
   
  return gradient;
}


PImage AddNoise(PImage img){
 float noiseScale = 0.1; 
  
  
img.loadPixels();
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int loc = x + y * img.width;
      color c = img.pixels[loc];
      
      float noise = random(0.95,1.05);
      
      // Adicionar ruído aos componentes de cor
      float r = red(c) * noise;
      float g = green(c) * noise;
      float b = blue(c) * noise;
      
      r = constrain(r, 0, 255);
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);
      
      // Definir o novo valor do pixel
      img.pixels[loc] = color(r, g, b);
    }
  }
  
  img.updatePixels();
  return img;
}
