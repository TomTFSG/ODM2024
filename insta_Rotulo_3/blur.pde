PImage Filter1D(PImage img) {
      PImage aux = img.get();
      int kRadius = (k-1)/ 2;
      
      //println(kRadius);
      
      float sumRed = 0;   
      float sumGreen = 0;
      float sumBlue = 0;
      float valRed = 0;
      float green = 0;
      float valBlue = 0;
      
      int pos = 0;
      
      //carregar os pixeis da Imagem da camera atual.
        aux.loadPixels();
    
      //Criar uma nova imagem 
        PImage result =  createImage(img.width, img.height, RGB);
        PImage blurImg = createImage(img.width, img.height, RGB);
        
        result.loadPixels();
      
      // Primeira convolução na direção X
      for (int y = 0; y < aux.height; y++) {
        for (int x = kRadius; x < aux.width - kRadius; x++) {
                sumRed = 0;   
                sumGreen = 0;
                sumBlue = 0;
          for (int i = -kRadius; i <= kRadius; i++) {
                pos = y * aux.width + x + i;
                
                 //Red
                valRed = red(aux.pixels[pos]);
                sumRed += kernelX.get(i+(k-1)/2) * valRed;
      

                green= green(aux.pixels[pos]);
                sumGreen += kernelX.get(i+(k-1)/2) * green;
      
                // Blue
                valBlue = blue(aux.pixels[pos]);
                sumBlue += kernelX.get(i+(k-1)/2) * valBlue;
          }
          result.pixels[y * aux.width + x] =  color(sumRed*(sigma*2), sumGreen*(sigma*2), sumBlue*(sigma*2));
        }
      }
      
      blurImg.loadPixels();
      
            // Primeira convolução na direção X
     for (int x = 0; x < aux.width; x++) {
        for (int y = kRadius; y < aux.height - kRadius; y++) {
                sumRed = 0;   
                sumGreen = 0;
                sumBlue = 0;
          for (int i = -kRadius; i <= kRadius; i++) {
                pos = (y+i) * aux.width + x ;
                
                 //Red
                valRed = red(result.pixels[pos]);
                sumRed += kernelY.get(i+(k-1)/2) * valRed;
      
                // Green
                green = green(result.pixels[pos]);
                sumGreen += kernelX.get(i+(k-1)/2) * green;
      
                // Blue
                valBlue = blue(result.pixels[pos]);
                sumBlue += kernelY.get(i+(k-1)/2) * valBlue;
          }
          blurImg.pixels[y * aux.width + x] =  color(sumRed*(sigma*2), sumGreen*(sigma*2), sumBlue*(sigma*2));
        }
      }
      
      blurImg.updatePixels();
      result.updatePixels();
      return blurImg.get();
}

void kernelGauss(){ //definir o tamnho do kernel
  k = int(2*PI*sigma);
  if(k % 2 == 0){
    k++;
  }
    //println(k);
}

void defGaussianKernel(){ //perciso de calcular os valores do kernel normal?
     kernelGauss();
     float r = 1; //razão
     float escala = 0;
     float total = 0;
     float [][] kernelAux  = new float [k][k];
     int I=0;
     int J=0;
     
     for(int i = 0; i<k ; i++){ 
       for(int j = 0; j<k ; j++){
               I=i-((k-1)/2);
               J=j-((k-1)/2);
               kernelAux[i][j] = (1/(2*pow(PI,2)*sigma))*pow(exp(1),-0.5*((pow(I,2)+pow(J,2))/pow(sigma,2)));
               //println("[ i :" + I +", j:" + J + "] - " + kernelAux[i][j]);
               
           if(i == 0 && j == 0){
              r = round(1/kernelAux[i][j]); //encontrar a razão para normalizar o valor minimo a um 
              println("razao: "+r);  
            }
           
               kernelAux[i][j] = round(kernelAux[i][j]*r);
               //println("[ i :" + I +", j:" + J + "] - " + kernelAux[i][j]);
               total += kernelAux[i][j];
               //println("[ i :" + i +", j:" + j + "] - " + kernelAux[i][j]);
           
           if((k-1)/2==i){
             println("[ i :" + i +", j:" + j + "] - " + kernelAux[i][j]);
             kernelY.add(kernelAux[i][j]);
           }
           if((k-1)/2==j){
             println("[ i :" + i +", j:" + j + "] - " + kernelAux[i][j]);
             kernelX.add(kernelAux[i][j]);
           }
           
       }
     }
     
     escala = 1/total;
     
     //função 2d kernel para definir a escala 
      
     for(int i = 0; i<k; i++){ 
         //println("bb");
         kernelX.set(i, kernelX.get(i)*escala);
         kernelY.set(i, kernelY.get(i)*escala);
     }
}
