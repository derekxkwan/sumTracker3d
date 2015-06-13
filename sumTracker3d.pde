int N=1024;
float allmax=1800;
int histNum = 10000000;
int currentCount = 0;
float rot=0;
PVector[] hist = new PVector[histNum];

 String[] jointList= {
    "righthand","lefthand","rightelbow","leftelbow","rightfoot","leftfoot","rightknee","leftknee","head","torso","leftshoulder","rightshoulder","lefthip","righthip" };
  
  /* String[] jointList= {
    "leftfoot", "lefthand", "righthand" };
    */
    Tracker myTracker;


void draw(){

float allx=0;
float ally=0;
float allz=0;

  for (String i :jointList) {
  //println( "dfsdfsd"+myTracker.getJoint(i).x); 
   allx+= myTracker.getJoint(i).x;
   ally+= -myTracker.getJoint(i).y;
   allz+= -myTracker.getJoint(i).z; 
  // println(myTracker.getJoint(i).y);
  }  //Adjust Coefficients Based On Mouse Position
     //println(ally);
float thismax= max(max(abs(allx),abs(ally)),abs(allz));
if (thismax>allmax) allmax=thismax;
     println(allmax);
if(allmax==0) allmax=.00000001;
allx/=allmax;
ally/=allmax;
allz/=allmax;

background(allx*0.5, ally*0.5, allz*0.5);

float plotx= (allx*(N/4)); //+N/2+100;
float ploty= (ally*(N/4)); //+N/2;
float plotz= (allz*(N/4)); //+N/2;
//print(plotx); 
 //println(plotx +","+ploty +","+plotz+","+allmax);
//point(plotx,ploty);
int modCount = currentCount % histNum;
hist[modCount] = new PVector();
hist[modCount].set(plotx, ploty, plotz);
 translate(width/2, height/2);
 rotateY(rot);
stroke(1, 1, 1, 0.5);  

currentCount++;
  rot+=.01;
for(int i=100; i<histNum ;i++){
  //pushMatrix();
  //println(i);
//translate(width/2, height/2);

  PVector p= hist[i];

  if ((i<currentCount)) {

    point(p.x,p.y,p.z);};
//translate(width/2, height/2);
  

//popMatrix();  
}


}
void setup(){
   size(N,N,P3D);
    ortho();
   
  myTracker=new Tracker(jointList);  
    background(0);
//color(255,255,255);
//stroke(255,255,255);
 colorMode(RGB, 1.0);
  frameRate(30);

}
 
