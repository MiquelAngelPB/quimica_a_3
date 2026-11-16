int[] quimicoA;
int[][] quimicoB;
int[] vacio;

int[] siguienteQuimicoA;
int[][] siguienteQuimicoB;
int[] siguienteVacio;

int ConteoMuertesBlack = 0;
int ConteoMuertesYellow = 0;
int Vacios = 0;


void setup(){ //<>//
  size(500,500, JAVA2D);
  
  loadPixels();
  quimicoA = new int[pixels.length];
  quimicoB = new int[pixels.length][2];
  vacio = new int[pixels.length];
  
  siguienteQuimicoA = new int[pixels.length];
  siguienteQuimicoB = new int[pixels.length][2];
  siguienteVacio = new int[pixels.length];
  
  for(int i = 0; i < pixels.length; i++){
    
    float ran =  random(0,1);
  
    if(ran <= .500){
      quimicoA[i] = 1;
      quimicoB[i][0] = 0;
      quimicoB[i][1] = 0;
      vacio[i] = 0;
    }
    else if (ran <= .666){
      quimicoA[i] = 0;
      quimicoB[i][0] = 1;
      quimicoB[i][1] = 100;
      vacio[i] = 0;
    }
    else{      
      quimicoA[i] = 0;
      quimicoB[i][0] = 0;
      quimicoB[i][1] = 0;
      vacio[i] = 1;    
    }
    
  }
}

void draw(){
  delay(100);
  
  color yellow = color(255, 255, 0);
  color black =  color(0,0,0);
  
  loadPixels();
  for(int i = 0; i < pixels.length; i++){
    if(quimicoA[i] == 1 && quimicoB[i][0] == 0){
      pixels[i] = yellow;
    }
    else if (quimicoA[i] == 0 && quimicoB[i][0] == 1){
      pixels[i] = black;
    }
    else{
      pixels[i] = color(255,255,255);
    }
    

    try{ 
      
      //Si cualquiera de los pixeles que toca quimico A[i] es B, [i] pasa a ser B.
        if((i + 1 < pixels.length && i - 1 >=0 && i + width < pixels.length && i - width >= 0) /*<--Evitar errores*/&& quimicoA[i] == 1 && (quimicoB[i+1][0] == 1 || quimicoB[i - width][0] == 1 || quimicoB[i + width][0] == 1 || quimicoB[i - 1][0] == 1)){
          siguienteQuimicoA[i] = 0;
          siguienteQuimicoB[i][0] = 1;
          siguienteQuimicoB[i][1] = 100;
          ConteoMuertesYellow += 1;
        }
      //Si existe hueco para expandirse A pasa a ser 1
        else if((i + 1 < pixels.length && i - 1 >=0 && i + width < pixels.length && i - width >= 0) /*<--Evitar errores*/  && vacio[i] == 1 && ((quimicoA[i + 1] == 1 && quimicoB[i + 1][0] == 0) || (quimicoA[i + width] == 1 && quimicoB[i + width][0] == 0) || (quimicoA[i - width] == 1 && quimicoB[i - width][0] == 0) || (quimicoA[i - 1] == 1 && quimicoB[i - 1][0] == 0))){
          siguienteQuimicoA[i] = 1;
          siguienteQuimicoB[i][0] = 0;
          siguienteQuimicoB[i][1] = 0;
          siguienteVacio[i] = 0;
        }
        //Si 
        else if((i + 1 < pixels.length && i - 1 >=0 && i + width < pixels.length && i - width >= 0)  /*<--Evitar errores*/ && quimicoB[i][1] == 0){
          siguienteQuimicoA[i] = 0;
          siguienteQuimicoB[i][0] = 0;
          siguienteQuimicoB[i][1] = 0;
          siguienteVacio[i] = 1;

          ConteoMuertesBlack += 1;
          Vacios += 1;
          
        }
    }catch(ArrayIndexOutOfBoundsException e){
      e.printStackTrace();
    }
    

  }

  for(int i = 0; i < pixels.length; i++){
    quimicoA[i] = siguienteQuimicoA[i];
    quimicoB[i][0] = siguienteQuimicoB[i][0];
    if(siguienteQuimicoB[i][1] >= 1){
      quimicoB[i][1] = siguienteQuimicoB[i][1] - 1;
    }
    vacio[i] = siguienteVacio[i];

    siguienteQuimicoA[i] = 0;
    siguienteVacio[i] = 0;
    siguienteQuimicoB[i][0] = 0;
    siguienteQuimicoB[i][1] = 0;

  }

  updatePixels();

  println("Black quimic anihilated: ",ConteoMuertesBlack, "Yellow quimic anihilation: ", ConteoMuertesYellow, "Voids: ", Vacios);

}