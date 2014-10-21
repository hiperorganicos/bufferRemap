/* Sketch que guarda um buffer de dados, 
   para ajustar valores de normatização
   conforme variação de valores máximos e mínimos
   
   prog: Barbara Castro | artista e designer
   data: 12/10/2014
*/

import controlP5.*;
ControlP5 cp5;

float data = .4;
Slider slide;

DataIn d0;

void setup() {
  size(700,200);
  cp5 = new ControlP5(this);
  
  // add a horizontal sliders, the value of this slider will be linked
  // to variable 'sliderValue' 
  cp5.addSlider("data")
     .setPosition(50,30)
     .setRange(-5,5)
     .setSize(600, 50);
     ;
     
     d0 = new DataIn("d", data, 1, 400);
}

void draw() {
  
  background(0);
     d0.update(data);
     d0.display();
}

