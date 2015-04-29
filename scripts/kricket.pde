/*

Created by : Chad Hokama

"...and always let stochastics be your guide."
	       	   	 -Jiminey Cricket, in a parallel universe where 
			  Jiminiey Cricket isn't a total ass-clown.

*/




Integrator[] interpolators;
float dx,y_bar,maxln, minln, eps;
int nbdots, t;


void setup(){
  //size(300,275);
  size(175,100);
  t = 0;
  nbdots = width;
  y_bar = height/2;
  maxln = y_bar;
  minln = y_bar;
  dx = width/nbdots;
  interpolators = new Integrator[nbdots+1];
  for (int i = 0 ; i<=nbdots ; i++){    
    interpolators[i] = new Integrator( y_bar );
  }
  smooth();
}

/*||||||||DRAW||||||||*/

void draw(){
  background(0);
  
  for (int i = 0 ; i<=nbdots ; i++){
    interpolators[i].update();
  } 
  
  if ( millis() -t > (100+random(2000)) ){
    setTarget();
    t = millis();
  }
  
  eps	= random(5);
  
  for (int i = 0 ; i<=nbdots ; i++){  
    float y = interpolators[i].value();
    ellipse(i*dx,y,4,1);    
    //fill((i==100 ? #FF0D00 : #000000))
    ellipse(i*dx,y_bar+random(-eps,eps),1,1);
    maxln = (y > maxln ? y:maxln);
    minln = (y < minln ? y:minln);
  }   
/*
  textSize(9);
  text("\"...and always let stochastics be your guide.\"",0,minln-1);  
  text("-Gemini Kricket",width-64,maxln+10);
*/  
  stroke(255,100);
  line(0,maxln+1,width,maxln+1);
  line(0,minln-1,width,minln-1);
  line(0,maxln+1,0,minln-1);
  line(width-1,maxln+1,width-1,minln-1);  
  maxln -= 15;
  minln += 15;
    
}



/*|||||||SETTARGET|||||||||*/

void setTarget(){
  float y;
  for (int i = 0 ; i<=nbdots ; i++){
   if (i % 2 == 0){
     y = random(y_bar);
   }else{
     y = y_bar+random(height-y_bar);
   }
    y = random(height);
    interpolators[i].target(y);
  } 
}