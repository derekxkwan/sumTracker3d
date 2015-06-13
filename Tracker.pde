  import oscP5.*;
import netP5.*;
import java.util.Map;

class Tracker
{
HashMap<String, joint> jointDict = new HashMap<String, joint>();
OscP5 oscP5;
NetAddress synMrl, scMrl;



  Tracker(String[] jointList){


    
  oscP5 = new OscP5(this, 12345);
  synMrl = new NetAddress("127.0.0.1", 12346);

  initialize();   
 
    
  }
 
 
joint getJoint(String jointName)
 {
   sendSynOSC();
 return  jointDict.get(jointName);
 
 
 }
 
 
 void initialize() {

  for (String i :jointList) {
   joint  tmp = new joint(i, 0, 0, 0);
    jointDict.put(i, tmp);
  }
}
void sendSynOSC() {
  for (String i :jointList) {
    OscMessage thisMsg= new OscMessage("/"+i+"_trackjointpos");
    thisMsg.add(1);
    oscP5.send(thisMsg, synMrl);
  }
}

void oscEvent(OscMessage theOscMessage) {

  for (String i :jointList) {
    /* check if theOscMessage has the address pattern we are looking for. */

    if (theOscMessage.checkAddrPattern("/"+i+"_pos_body")==true) {
      joint tmp = jointDict.get(i);
      tmp.x=theOscMessage.get(0).floatValue();
      tmp.y = theOscMessage.get(1).floatValue();
      tmp.z = theOscMessage.get(2).floatValue();
    jointDict.put(i, tmp);
      //print("### received an osc message /test with typetag ifs.");
      //  println(i+"XYZ: "+ tmp.x +", "+tmp.y +", "+tmp.z);
      return;
      //  }
    } }

  }
 
  
}
