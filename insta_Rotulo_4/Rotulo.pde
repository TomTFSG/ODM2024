class Rotulo{
  PVector pos      = new PVector(0,0,0);
  PVector posInsta = new PVector(0,0,0);
  
  int dimI [] = new int [2];
  PImage imagens [] = new PImage [2];
  String textos [] = new String [2];
  int textoSize [] = new int [2];
  int rectDim [] = new int [2];
   int weightT = 270;
   int spaceT = 0;
   
   boolean toGray;
   
   //Roboto-Regular-48
   //Roboto-Bold-48
    
  Rotulo(PVector pos, PImage foto, PImage load){
    //posicao 
    this.pos = pos;
    
    //imagens
    imagens[0] = foto.copy();
    imagens[1] = load;
    updateImage();
    
    //dimensoes para posicionar load
    dimI[0] = imagens[0].width;
    dimI[1] = imagens[0].height;
    
    //Alterações de Imagem
    imagens[1].resize(int(dimI[0]/3.4), int(dimI[0]/3.4));
    
    //Textos
    textos[0] = tipos[int(random(tipos.length))];
    textos[1] = legendas[int(random(legendas.length))];
    
    textoSize[0] = 13*(dimI[1]/weightT);
    textoSize[1] = 10*(dimI[1]/weightT);
    
    //whiteBox
    rectDim[1] = textoSize[0]+textoSize[1]+(8*(dimI[1]/weightT));
    
    this.pos.y += rectDim[1];
    
    //pos image
    posInsta.x = pos.x + (dimI[0]/2) - (imagens[1].width/2);
    posInsta.y = pos.y + rectDim[1]  + (dimI[1]/2) - (imagens[1].height/2);
    
    spaceT = int(0.5f*(dimI[1]/weightT));
   
  }
   
  void display(){
     image(imagens[0], pos.x, pos.y);
     image(imagens[1], posInsta.x, posInsta.y);
     
     fill(255);
     noStroke();
     rect(pos.x, (pos.y), dim[0], rectDim[1]);
     
     
     textAlign(LEFT);
     
     textFont(T);
     fill(0);
     textSize(textoSize[0]);
     text(textos[0], pos.x+7, pos.y+textoSize[0]+2);
     
     textFont(L);
     textSize(textoSize[1]);
     text(textos[1], pos.x+7, pos.y+textoSize[1]+textoSize[0]+(spaceT*2)+2);
     
  }
  
  void updateImage(){
      //PImage effect = perlinNoise(width, height, 0.001);
      //effect = Gaussian.apply(generateNormalMap(effect).copy(), 7, 2);
      
      
      //imagens[0] =  glassEffect(effect, imagens[0],20);
      imagens[0] =  Filter1D(imagens[0]); 
      imagens[0] =  imagens[0].get(kernelX.size(),kernelY.size(),(dim[0]*dimSegMult) - kernelX.size()*2,(dim[1]*dimSegMult) - kernelY.size()*2);
      imagens[0].resize(dim[0],dim[1]);
      
      PImage effect = perlinNoise(imagens[0].width,imagens[0].height, random(0.002,0.003));
      PImage normal = generateNormalMap(effect); 
      effect = Gaussian.apply(normal, 7, 2);     
      imagens[0] =  glassEffect(effect, imagens[0], 20);
      
      imagens[0] = AddNoise(imagens[0]);

      if(random(1)>=0.7)toGray = true;
      else toGray = false;
      imagens[0] =  girarMatiz(imagens[0], toGray, int(random(360))); 

      imagens[0] =  Brightness.apply(imagens[0], 25);
  }
  
  void updateImageFoto(PImage foto){
    imagens[0] = foto.copy();
    
    updateImage();
  }
}
