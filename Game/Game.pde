import ddf.minim.*;


import java.awt.Rectangle;

boolean intro;//if intro true else false
PFont font;//font elephant regular 48
PImage loadp1, loadp2, loadp3, loadp4,p1img,p2img,p1img2,p2img2,p1sword,p2sword,p1shield,p2shield;//Loading img for char
float c=0;//color change for the text in begining
color t;//temp color
int p1char,p2char;
PImage back1,rheart,bheart,fire,fire2,p2move,p1move,sunimg,rainimg,sunflare,banner1,banner2,winner;
int x,y,x2,y2;
int p1d,p2d;
int p1atkfps=0;
int p2atkfps=0;
int p1blockfps=0;
int p2blockfps=0;
int p1health,p2health;
int winfps,backfps,jumpfps,jumpfps2;
Rectangle temp,temp2;//cbox for p1,p2
Rectangle p1cbs,p2cbs;//p1 collision box and p2 for sword
int tempr1,tempr2;
Rain[] r = new Rain[2000];

int sunfps,deathfps,rainsoundfps,sunsoundfps;//sun movement
int fps;//games alltime fps only geos up
boolean sun , rain, dead;
Minim minim;
AudioPlayer rainsound,thunder,attacksound,blocksound,healthsound,click,sunsound,step;
PImage cursor;
boolean p1hurt,p2hurt;


void setup() {
  size(1200, 800);
  cursor=loadImage("swordcursor.png");
  cursor(cursor,0,0);
  minim = new Minim(this);
  background(0);
  frameRate(30);
  intro=true;
  font=loadFont("Elephant-Regular-48.vlw");
  loadp1=loadImage("p1.png");
  loadp2=loadImage("p2.png");
  loadp3=loadImage("p3.png");
  loadp4=loadImage("p4.png");
  p1sword=loadImage("p1sword.png");
  p2sword=loadImage("p2sword.png");
  p1shield=loadImage("shield.png");
  p2shield=loadImage("shield2.png");
  fire=loadImage("fire.png");
  fire2=loadImage("fire.png");
  back1=loadImage("background1.png");
  p2move=loadImage("p2move.png");
  p1move=loadImage("p1move.png");
  sunimg=loadImage("sun.png");
  rainimg=loadImage("rain.png");
  sunflare=loadImage("sunflare.png");
  winner=loadImage("winner.jpg");
  dead=false;
  
  
  
  p1char=0;
  p2char=0;
  p1d=1;
  p2d=0;
  p1health=4;
  p2health=4;
  rheart=loadImage("rheart.png");
  bheart=loadImage("bheart.png");
  sun=false;
  rain=false;
  sunfps=0;
  deathfps=0;
  rainsoundfps=0;
  jumpfps=0;
  p1hurt=false;
  p2hurt=false;
  //starting values for p1
  x=225;
  y=height-(height/3);
  
  x2=width-450;
  y2=height-(height/3);
  
  for(int k=0;k<r.length;k++){
      r[k]=new Rain();
      
    }
    
    
    rainsound = minim.loadFile("rainsound.wav");
    thunder = minim.loadFile("thunder1.wav");
    attacksound = minim.loadFile("attack.wav");
    blocksound = minim.loadFile("block.wav");
    healthsound = minim.loadFile("health.wav");
    click = minim.loadFile("click.wav");
    sunsound = minim.loadFile("sun.wav");
    step = minim.loadFile("step.wav");
}

void draw()
{
  if(intro)
  {
    
    //change hue of text
    colorMode(HSB);
    if (c >= 255)
      c=0;  
    else  
      c++;
     color t=color(c,255,255);
    textAlign(CENTER);
    textSize(48);
    fill(t);
    text("Pick two characters!", width/2-25, height/4);
    text("<--- Player 1 & Player 2 --->\n\t\tKeyboard", width/2.15, height/1.2);
    //
    int sunh=10;
    int rainh=10;
    if(sun)
      sunh=-75;
     if(rain)
       rainh=-75;
    rect(15,90,75,sunh);
    rect(100,90,80,rainh);
    image(sunimg, 20, 20);
    image(rainimg, 110, 20);
    
    if(mousePressed)
    {
      
      click.rewind();
      click.play();
      
    }
    
    if(mousePressed && mouseX>20 && mouseX<20+64 && mouseY>20 && mouseY<20+64&&rain!=true){
      sunh=-75;
      sun=true;
    }
    if(mousePressed && mouseX>100 && mouseX<100+64 && mouseY>20 && mouseY<20+64&&sun!=true){
      rainh=-75;
      rain=true;
    }
    //Draw char images
    image(p2move, width/1.5, height/1.5,300,300);
    image(p1move, width/55, height/1.5,300,300);
    
    image(loadp1, width/6, height/3,228,228);
    image(loadp2, width/3.5, height/3,228,228);
    image(loadp3, width/2.4, height/3,228,228);
    image(loadp4, width/1.85, height/3,228,228);
    
    
    
    //draws rectangles under character
    int rh1=30;//-230 for over char
    int rh2=30;//change the width when selected 
    int rh3=30;
    int rh4=30;
    colorMode(RGB);
    if(mousePressed && mouseX>width/5 && mouseX<width/5+128 && mouseY>height/3 && mouseY<height/1.6+30){//change width for new location to check /5,/3.1
      
      if(mouseButton==LEFT&&p1char==0)//left click
      {
        p1char=1;
        rh1=-230;
      }
      else if(p2char==0&&mouseButton==RIGHT)//right click
      {
        p2char=1;
        rh1=-230;
      }
    
    } 
    fill(255,255,153);
    rect(width/5, height/1.6,128,rh1);
    
    if(mousePressed && mouseX>width/3.1 && mouseX<width/3.1+128 && mouseY>height/3 && mouseY<height/1.6+30){
       if(mouseButton==LEFT&&p1char==0)
       {
        p1char=2;
        rh2=-230;
       }
      else if(p2char==0&&mouseButton==RIGHT)
      {
        rh2=-230;
        p2char=2;
      }
    }
    fill(255,0,255);
    rect(width/3.1, height/1.6,128,rh2);
    
    if(mousePressed && mouseX>width/2.19 && mouseX<width/2.19+128 && mouseY>height/3 && mouseY<height/1.6+30){
      
      
     if(mouseButton==LEFT&&p1char==0)
     {
        p1char=3;
        rh3=-230;
     }
      else if(p2char==0&&mouseButton==RIGHT)
      {
        p2char=3;
        rh3=-230;
      }
    }
    fill(51,255,51);
    rect(width/2.19, height/1.6,128,rh3);
    
    if(mousePressed && mouseX>width/1.73 && mouseX<width/1.73+128 && mouseY>height/3 && mouseY<height/1.6+30){
      if(mouseButton==LEFT&&p1char==0)
      {
        p1char=4;
        rh4=-230;
      }
      else if(p2char==0&&mouseButton==RIGHT)
      {
        rh4=-230;
        p2char=4;
      }
    }
    fill(51,255,255);
    rect(width/1.73, height/1.6,128,rh4);
    println(p1char);
    println(p2char);
    if(p1char>0&&p2char>0)
    {
      p1img=loadImage("p"+p1char+".png");
      p1img2=loadImage("p"+p1char+"r.png");
      banner1=loadImage("p"+p1char+"b.png");
      
      p2img=loadImage("p"+p2char+".png");
      p2img2=loadImage("p"+p2char+"r.png");
      banner2=loadImage("p"+p2char+"b.png");
      intro=false; 
    }
    
  }
  
  //
  //
  //
  //
  //
  //END OF INTRO SEQUENCE
  //
  //
  //
  //
  //
  else{
      fps++;
      image(back1,0,0);//paints background
      colorMode(HSB);
    if (c >= 255)
      c=0;  
    else  
      c++;
     color t=color(c,255,255);
     tint(c,255,255,255);
       image(fire,674,381,150,96);
       image(fire,387,381,150,96);
     colorMode(RGB);
     noTint();
    fill(0);
    textSize(60);
    image(banner1,275,325);
    image(banner2,800,325);
    
    
    noCursor();
    image(bheart,x+55,y-10,30,30);
    image(bheart,x+85,y-10,30,30);
    image(bheart,x+115,y-10,30,30);
    image(bheart,x+145,y-10,30,30);
   
    image(bheart,x2+55,y2-10,30,30);
    image(bheart,x2+85,y2-10,30,30);
    image(bheart,x2+115,y2-10,30,30);
    image(bheart,x2+145,y2-10,30,30);
    for(int k=1;k<=p1health;k++)//draws red hearts over black hearts
      image(rheart,x+25+(30*k),y-10,30,30);
    
    for(int k=1;k<=p2health;k++)//draws red hearts over black hearts
      image(rheart,x2+25+(30*k),y2-10,30,30);
    
    //direction
    if(p1hurt)
        {
          tint(255,0,0,200); 
        } 
      if(p1d==0&&p1health>0&&p2health>0)//direction and heal
        image(p1img,x,y,228,228);
      else if(p1health>0&&p2health>0)
        image(p1img2,x,y,228,228);
        
        
        noTint();
       if(p2hurt)
        {
          tint(255,0,0,200); 
        } 
      if(p2d==0&&p2health>0&&p1health>0)//direction and health
        image(p2img,x2,y2,228,228);
      else if(p2health>0&&p1health>0)
        image(p2img2,x2,y2,228,228);
       
        noTint();
        if(p1health<=0||p2health<=0){
          deathfps++;
          if(deathfps>100)
            reset();
        }

    //
    noFill();
    //rect(x+50,y,120,228);
    //rect(x2+50,y2,120,228);
    temp=new Rectangle(x+50,y,120,228);
    temp2=new Rectangle(x2+50,y2,120,228);
    
    
    //p1 attack
    if(p1atkfps!=0)
    {
      if(p1d==1){
        image(p1sword,x+100,y+100);
        noFill();
        if(p1atkfps==1){
          attacksound.rewind();
          attacksound.play();
          
        }
        //rect(x+140,y+120,150,50);
        fill(#FF604E);
        if(p1atkfps>15)
          fill(#E2220D);
        //rect(x+115,y+30,10,+(p1atkfps-40));
        p1cbs=new Rectangle(x+140,y+120,150,50);
        if(collision(p1cbs,temp2)&&p1atkfps==10&&p2blockfps==0){//checks collision and only does it on first frame
          p2health-=1;
          p2hurt=true;
          healthsound.rewind();
          healthsound.play();
        }
      p1atkfps++;
      if(p1atkfps>40){
        p1atkfps=0;
        p2hurt=false;
      }
    }
    }
    
    //p2attack
    if(p2atkfps!=0)
    {
      if(p2d==0){
        image(p2sword,x2-70,y2+100);
        if(p2atkfps==1){
          attacksound.rewind();
          attacksound.play();
          
        }
        noFill();
        //rect(x2-60,y2+125,150,50);
        fill(#FF604E);
        if(p2atkfps>10)
          fill(#E2220D);
        //rect(x2+105,y2+30,10,+(p2atkfps-40));
        p2cbs=new Rectangle(x2-60,y2+125,150,50);
        if(collision(p2cbs,temp)&&p2atkfps==15&&p1blockfps==0){//checks collision and only does it on first frame
          p1health-=1;
          p1hurt=true;
          healthsound.rewind();
          healthsound.play();
        }
      }
      p2atkfps++;
      if(p2atkfps>40){
        p2atkfps=0;
        p1hurt=false;
        
      }
    }
    if(p1blockfps>0)
    {
      image(p1shield,x+50,y+100);
      fill(#28F2FF);
      //rect(x+115,y+30,10,+(p1blockfps-40));
      p1blockfps++;
      if(p1blockfps==40)
        p1blockfps=0;
    }
    
    if(p2blockfps>0)
    {
      image(p2shield,x2+30,y2+100);
      fill(#28F2FF);
      //rect(x2+105,y2+30,10,+(p2blockfps-40));
      p2blockfps++;
      if(p2blockfps==40)
        p2blockfps=0;
    }
    
    if(jumpfps>0)
    {
      if(jumpfps<20)
        y-=jumpfps;
      jumpfps++;
      if(jumpfps>=20)
      {
        y+=jumpfps-20;
        if(jumpfps>=40){
          jumpfps=0;
          y=height-(height/3);
        }
      }
      
      
    }
    
    if(jumpfps2>0)
    {
      if(jumpfps2<20)
        y2-=jumpfps2;
      jumpfps2++;
      if(jumpfps2>=20)
      {
        y2+=jumpfps2-20;
        if(jumpfps2>=40){
          jumpfps2=0;
          y2=height-(height/3);
        }
      }
      
      
    }
    
    
    
    
    if(rain){
    fill(50,50,50,100);
    rect(0,0,width,height);
    
    for(int k=0;k<r.length;k++){
      r[k].fall();
      r[k].show();
      
    }
    if(random(1,500)>499){//lightning
      background(255);
      thunder.rewind();
      thunder.play();
    }
    if(rainsoundfps==0){
      rainsound.rewind();
      rainsound.play();
     rainsound.setGain(-5.0);
    }
     rainsoundfps++;
     if(rainsoundfps>1750)
      rainsoundfps=0; 
    }
    
    
    
    if(rain!=true&&sun!=true||sun)
    {
      if(fps%20==0)
        sunfps++;
         image(sunflare,-100+sunfps,-100);
         if(sunfps>height+400)
           sunfps=-200;
           
      if(sunsoundfps==0){
        sunsound.rewind();
         sunsound.play();
         sunsound.setGain(-5.0);
      }
      
     sunsoundfps++;
     if(sunsoundfps>500)
      sunsoundfps=0; 
      
    }
    
    
   if(p1health<=0||p2health<=0){
      dead=true;
      rainsound.pause();
      sunsound.pause();
      rain=false;
   }
 //
 //
 //
 //
 //
 //
 ///
 //
 ///
 ///
 ///
 ///
 ///
 ///
 ///
 ///
 ///
 ///
 ///
 //
 //GameOver
  }
  if(dead)
  {
    cursor();
    image(back1,0,0);
    filter(BLUR,6);
    if(p1health==0&&p2health==0)
    {
      image(banner1,70,height/6,328,328);
      image(banner2,width-390,height/6.,328,328);
      filter(BLUR,2);
      image(p1img2,width/2-246,height/1.72,328,328);
      image(p2img,width/2-82,height/1.72,328,328);
      
    }
    if(p1health==0&&p2health>0)
    {
      
      image(banner2,70,height/6,328,328);
      image(banner2,width-390,height/6.,328,328);
      filter(BLUR,2);
      image(p2img2,width/2-164,height/1.72,328,328);
      
    }
    
    if(p2health==0&&p1health>0)
    {
      
      image(banner1,70,height/6,328,328);
      image(banner1,width-390,height/6.,328,328);
      filter(BLUR,2);
      image(p1img2,width/2-164,height/1.72,328,328);
      
    }
    
    
    
    
    
    
    
    
    fill(50,100);
    rect(width/2-245,height/2-200,500,150);
    rect(width/2-245,height/2,500,150);
    fill(0);
    textSize(100);
    text("RESTART",width/2,height/2-100);
    text("QUIT",width/2,height/2+115);
    
    if(mouseX>width/2-245 && mouseX<width/2+255 && mouseY>height/2-200 && mouseY<height/2-50)
    {
     fill(10,100);
     rect(width/2-245,height/2-200,500,150);
    fill(100);
    textSize(104);
    text("RESTART",width/2,height/2-100);
    if(mousePressed)
      reset();
      
    }
    
    if(mouseX>width/2-245 && mouseX<width/2+255 && mouseY>height/2 && mouseY<height/2+150)
    {
     fill(10,100);
     rect(width/2-245,height/2,500,150);
     fill(100);
    textSize(104);
    text("QUIT",width/2,height/2+115);
    if(mousePressed)
      exit();
     
      
    }
  }
    
}




//checks if two rectangles collide, returns true if they do
boolean collision(Rectangle RectA,Rectangle RectB)
{
  
  
  if(RectA.intersects(RectB))
    return true;
  return false;
}

void keyReleased() {
  if(p1health>0&&p2health>0)
  {
    if (key == 'a'&&x>10) 
    {
        x-=20;
        p1d=0;
        step.rewind();
        step.play();
        step.setGain(-40.0);
        p1atkfps=0;
    }
    if (key == 'q'&&p1blockfps==0&&jumpfps==0) 
    {
        jumpfps=1;
      
      
    }
    
    if (key == 'd'&&x<x2-150) 
    {
        x+=20;
        p1d=1;
        step.rewind();
        step.play();
        step.setGain(-40.0);
    }
    if (key == 'd'&&x<x2-150)
      p1d=1;
    if (key == 's'&&p1atkfps==0) 
    {
        p1blockfps=1;
        blocksound.rewind();
        blocksound.play();
    }
    
    if (key == 'w'&&p1atkfps==0&&p1blockfps==0) 
    {
        p1atkfps=1;//starts the sword timer for how long to draw
    }
    
    if (keyCode == LEFT&&x2>x+150) 
    {
        x2-=20;
        p2d=0;
        step.rewind();
        step.play();
        step.setGain(-40.0);
    }
    if (keyCode == LEFT)
      p2d=0;
    if (keyCode == RIGHT&&x2<width-200) 
    {
        x2+=20;
        p2d=1;
        step.rewind();
        step.play();
        step.setGain(-40.0);
        p2atkfps=0;
    }
    if (keyCode == UP&&p2atkfps==0&&p2blockfps==0) 
    {
       p2atkfps=1;
    }
    
    if (keyCode == 17&&p2blockfps==0&&jumpfps2==0) 
    {
       jumpfps2=1;
    }
    
    if (keyCode == DOWN&&p2atkfps==0&&p2blockfps==0) 
    {
       p2blockfps=1;
       blocksound.rewind();
       blocksound.play();
    }
    
    
  }
    
    
}
    void reset()
    {
      cursor=loadImage("swordcursor.png");
  cursor(cursor,0,0);
  minim = new Minim(this);
  background(0);
  frameRate(30);
  intro=true;
  font=loadFont("Elephant-Regular-48.vlw");
  loadp1=loadImage("p1.png");
  loadp2=loadImage("p2.png");
  loadp3=loadImage("p3.png");
  loadp4=loadImage("p4.png");
  p1sword=loadImage("p1sword.png");
  p2sword=loadImage("p2sword.png");
  p1shield=loadImage("shield.png");
  p2shield=loadImage("shield2.png");
  fire=loadImage("fire.png");
  fire2=loadImage("fire.png");
  back1=loadImage("background1.png");
  p2move=loadImage("p2move.png");
  p1move=loadImage("p1move.png");
  sunimg=loadImage("sun.png");
  rainimg=loadImage("rain.png");
  sunflare=loadImage("sunflare.png");
  winner=loadImage("winner.jpg");
  dead=false;
  
  
  
  p1char=0;
  p2char=0;
  p1d=1;
  p2d=0;
  p1health=4;
  p2health=4;
  rheart=loadImage("rheart.png");
  bheart=loadImage("bheart.png");
  sun=false;
  rain=false;
  sunfps=0;
  deathfps=0;
  rainsoundfps=0;
  jumpfps=0;
  p1hurt=false;
  p2hurt=false;
  //starting values for p1
  x=225;
  y=height-(height/3);
  
  x2=width-450;
  y2=height-(height/3);
  
  for(int k=0;k<r.length;k++){
      r[k]=new Rain();
      
    }
    
    
    rainsound = minim.loadFile("rainsound.wav");
    thunder = minim.loadFile("thunder1.wav");
    attacksound = minim.loadFile("attack.wav");
    blocksound = minim.loadFile("block.wav");
    healthsound = minim.loadFile("health.wav");
    click = minim.loadFile("click.wav");
    sunsound = minim.loadFile("sun.wav");
    step = minim.loadFile("step.wav");
}