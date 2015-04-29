PVector U;
float ro,sigma,beta,h;
float X,Y,Z;

void setup(){
  //size(500,500,P3D);   
  size(500,500);
  background(255,0);
  ro    = 280;
  sigma = 100;
  beta  = 80/3;  
  h     = 0.001;
  U     = new PVector(random(500),random(500),random(500));
}

void draw(){

  X = map(U.x,-190,270,10,width-10);
  Y = map(U.y,-250,300,10,height-10);
 
  noStroke();
  fill(0,70);
  //lights();
  //translate(X,Y,0);
  //sphere(1+abs(U.x/15));
  ellipse(X,Y,map(U.z,50,500,1,10),map(U.z,50,500,1,10));
  U = rk4(ro,sigma,beta,U,h);

}


/*  4th order Runge Kutta method
    k1 = lorenz(s,r,b,U(:,ix));
    k2 = lorenz(s,r,b,U(:,ix)+1/2*h*k1);
    k3 = lorenz(s,r,b,U(:,ix)+1/2*h*k2);
    k4 = lorenz(s,r,b,U(:,ix)+h*k3);
    U(:,ix+1) = U(:,ix) + h/6*(k1 + 2*k2 + 2*k3 + k4);
*/
PVector rk4(float ro,float sigma,float beta,PVector u,float h){

  PVector k1,k2,k3,k4;
 
  k1 = lorenz(ro,sigma,beta,u);  
  k2 = lorenz(ro,sigma,beta,PVector.add(u,PVector.mult(k1,h/2)));
  k3 = lorenz(ro,sigma,beta,PVector.add(u,PVector.mult(k2,h/2)));
  k4 = lorenz(ro,sigma,beta,PVector.add(u,PVector.mult(k3,h)));
  
  
  k1.mult(h/6); u.add(k1);
  k2.mult(2); k2.mult(h/6); u.add(k2); 
  k3.mult(2); k3.mult(h/6); u.add(k3);
  k4.mult(h/6); u.add(k4);
    
  return u;
  
}


PVector lorenz(float ro,float sigma,float beta,PVector u){
  PVector new_u = new PVector(0,0,0);
  
  new_u.x = sigma*(-u.x+u.y);
  new_u.y = ro*u.x-u.y-u.z*u.x;
  new_u.z = -beta*u.z+u.x*u.y;
  
  return new_u;
}

