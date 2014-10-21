class DataIn {
  String name;
  float val = .5;
  float valRemap; 
  float minRemap = 0;
  float maxRemap = 1;
  int bufferSize = 200;
  float [] buffer = new float[1];
  float minBuffer = 0;
  float maxBuffer = 1;
  float tE = 0.1;
  float minInterval;
  
  
  DataIn(String n, float v, float mI, int t){
    name = n;
    val = v;
    buffer[0] = v;
    minInterval = mI;
    bufferSize = t;
  }
  
  void update(float v){
    val = v;
    
    buffer = append(buffer, v);

    // expande area de atuação     
    if(v > maxRemap){
      maxRemap = v;
      valRemap = 1;
    }
    if(v < minRemap){
      minRemap = v;
      valRemap = 0;
    }
    
    //coleta valores maximos e minimos da memoria
    minBuffer = min(buffer);
    maxBuffer = max(buffer);
    
    
    //reduz area de atuação de acordo com estes valores da memoria
    if(maxRemap - minRemap > minInterval){
      
    if(maxRemap > maxBuffer){
      maxRemap = lerp (maxRemap, maxBuffer, tE);
    }
    
    if(minRemap < minBuffer){
      minRemap = lerp (minRemap, minBuffer, tE);
    }
    }
    
    // mantem o buffer dentro do tamanho especificado
    if(buffer.length > bufferSize){
      buffer = subset(buffer, 1, bufferSize);
    }
       
    valRemap = map(val, minRemap, maxRemap, 0.0, 1.0);
  }
  
  void display(){
    fill(0, 250, 190);
    stroke(200);
    strokeWeight(1);
    
    // desenha intervalo atual
    float x = map(minRemap, -5, 5, 50, 650);
    float w = map(maxRemap-minRemap, 0, 10, 0, 600);
    rect(x, 110, w, 40);
    
    // desenha valor
    stroke(0, 110, 250);
    strokeWeight(2);
    noFill();
    float valor = map(valRemap, 0, 1, x, x+w);
    line(valor, 110, valor, 150);
    
    float mw = map(minInterval, 0, 10, 0, 600);
    stroke(250, 250);
    line(valor-(mw/2), 107, valor+(mw/2), 107); 
    
    noStroke();
    
    textSize(10);
    fill(150);
    text(val, valor, 25);
    
    textSize(12); 
    fill(180);
    text(minRemap, x-5, 103);
    text(maxRemap, x+w-5, 103);
    
    fill(255);
    textSize(16);
    text(valRemap, valor, 170); 
    
  }   
}
