/*

Created by : Chad Hokama

"...and always let stochastics be your guide."
                         -Jiminey Cricket, in a parallel universe where
                          Jiminiey Cricket isn't a total ass-clown.

*/



/* 
   Requires Ben Fry's Integrator class found here:
   http://benfry.com/ndim/Integrator.java
   
   Or simplified here (kricket2D.pde implements this one):
   http://chadhokama.com/scripts/Integrator.pde

   Also, uses processing.js to display in context:
   http://js.processing.org

*/
Integrator[] x_interpolators;
Integrator[] y_interpolators;
float d,y_bar,x_bar,r_max,r_bound, eps, cx, cy;
int nbdots, t;


void setup(){

  size(160,180);
  t = 0;
  nbdots = width;
  y_bar = height/2;
  x_bar = width/2;
  
  r_max   = 1.4*(height < width ? height:width)/2;
  r_bound = 0;
  d = 0;
  
  x_interpolators = new Integrator[nbdots+1];
  y_interpolators = new Integrator[nbdots+1];
  
  for (int i = 0 ; i<=nbdots ; i++){
    x_interpolators[i] = new Integrator(x_bar);
    y_interpolators[i] = new Integrator( y_bar );
  }
  smooth();
}

/*||||||||DRAW||||||||*/

void draw(){
  background(0,0);
  stroke(0);
  strokeWeight(0);
  noStroke();
  fill(0,100);
  for (int i = 0 ; i<=nbdots ; i++){
    x_interpolators[i].update();
    y_interpolators[i].update();
  }

  if ( millis() -t > (100+random(2000)) ){
    setTarget();
    t = millis();
  }

  eps   = random(0.1*height); //think about it...
  ellipse(x_bar+random(-eps,eps),y_bar+random(-eps,eps),20,20);
  
  fill(60);
  for (int i = 0 ; i<=nbdots ; i++){
    float x = x_interpolators[i].value();
    float y = y_interpolators[i].value();
    
    ellipse(x,y,4,4);
    
    // set r_bound...
    d = sqrt(sq((width/2)-x) + sq((height/2)-y));
    r_bound = (d > r_bound ? d:r_bound);
    cx += x;    cy += y;
  }

  cx = cx/nbdots; cy = cy/nbdots;
  strokeWeight(10);
  stroke(0,40);
  noFill();
  ellipse(cx,cy,r_bound,r_bound);
  r_bound -= 5;

}



/*|||||||SETTARGET|||||||||*/

void setTarget(){
  float x,y;
  for (int i = 0 ; i<=nbdots ; i++){
    x = (width/2)+random(-r_max,r_max);
    y = (height/2)+random(-r_max,r_max);
    x_interpolators[i].target(x);
    y_interpolators[i].target(y);
  }
}

