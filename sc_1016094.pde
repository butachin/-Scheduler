int page=1;
int lec=0;

color bgClr = color(255); //background color
PFont font1;
PFont font2;

 void setup(){
  size(480,640);
  background(bgClr);
  smooth();
  frameRate(2); //frame rate:2 per 1 second
  font1 = loadFont("SansSerif.bold-48.vlw");
}

final int Days_of_Month[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
String DAY[] = {"SUN","MON","TUE","WED","THU","FRI","SAT"};

int zeller (int y, int m, int d) {
  int h;
  if (m < 3) {
    m = m + 12;
    y = y - 1;
  }
  h = (d + (m + 1) * 26 / 10 + (y % 100) + (y % 100) / 4 + y / 400 - 2 * y /100) % 7;
  h = h - 1;
  if (h < 0) {
    h = h + 7;
  }
    return h;
}
  
boolean Leap_Year (int y) {
  if (y % 400 == 0) {
    return true;
  } else if (y % 100 == 0) {
    return false;
  } else if (y % 4 == 0) {
    return true;
  }
  return false;
}
  
int Days_Count (int y, int m) {
  int days = Days_of_Month[m - 1];
  if (m == 2 && Leap_Year(y)) {
    days = days + 1;
  }
  return days;
}
  
void Calender (int y, int m, int d) {
  int i;
  int week = zeller (y, m, 1);
  int days = Days_Count (y, m);
  fill (255,255,0);
  text (y + "/" + m + "/" + d, 350, 50);
  for (i = 1; i <= days; i = i + 1) {
    if (i == d) {
      fill (255, 255, 0);//今日の日付を黄色で表示
    } else {
      fill (0);
      if ((i + week - 1) % 7 == 0) {
        fill (255, 0, 0);//日曜日を赤色で表示
      }else if((i + week) % 7 == 0){
        fill(0,0,255);//土曜日を青色で表示
      }
    }
    String s = (" " + i);
    s = s.substring (s.length() - 2);
    text (s, (i + week-1) % 7 * ((width - 10) / 7) + 30, ((i + week-1) / 7 + 2) * ((height - 60) / 7));
  }
}

void mouseClicked() {
  if(page==1){
    if(mouseX>220 && mouseX<260 && mouseY>450 && mouseY<490){
      page=2;
    }else if(mouseX>340 && mouseX<380 && mouseY>450 && mouseY<490){
      page=3;
    }
  }else if(page==2 || page==3){
    if(mouseY>10 && mouseY<30){
      if(mouseX>10 && mouseX<30){
        page=1;
      }else if(mouseX>50 && mouseX<70){
        page=2;
      }else if(mouseX>90 && mouseX<110){
        page=3;
      }
    }
  }
}

/*最初のページ*/
void page1(){
  background(bgClr);
  noStroke();
  color arcClr = color(#041643); //arche color
  float arcSize = 90; //arche size
  float arcStart = PI * 1.5; //start from 0 degree
  color tClr = color(#E8A700); //text color
  float tSize = 60; //text size
  
  textAlign(CENTER);
  textFont(font1, tSize);
 
  //hour
  fill(arcClr);
  arc(width * 0.2, height * 0.5, arcSize, arcSize, arcStart, arcStart + radians(map(hour() % 12, 0, 12, 0, 360)));
  fill(tClr);
  text(nf(hour(),2), width * 0.2, height * 0.5 + tSize/3);
 
  //:
  text(':', width * 0.35, height * 0.5 + tSize/3);
 
  //minute
  fill(arcClr);
  arc(width * 0.5, height * 0.5, arcSize, arcSize, arcStart, arcStart + radians(map(minute(), 0, 60, 0, 360)));
  fill(tClr);
  text(nf(minute(),2), width * 0.5, height * 0.5 + tSize/3);
 
  //:
  text(':', width * 0.65, height * 0.5 + tSize/3);
 
  //seconds
  fill(arcClr);
  arc(width * 0.8, height * 0.5, arcSize, arcSize, arcStart, arcStart + radians(map(second(), 0, 60, 0, 360)));
  fill(tClr);
  text(nf(second(),2), width * 0.8, height * 0.5 + tSize/3);
  
  fill(0);
  text("SCHEDULER",240,150);
  
  //移動
  textSize(22);
  strokeWeight(1);
  noFill();
  stroke(arcClr);
  rect(100,450,40,40);
  fill(arcClr);
  text("TOP",120,515);
  noStroke();
  rect(220,450,40,40);
  text("CALENDAR",240,515);
  rect(340,450,40,40);
  text("LECTURE",360,515);
  textAlign(0);
}

/*2ページ*/
void page2(){
  background(255);
  Calender(year(),month(),day());
  for(int i=0;i<9;i++){
    stroke(0);
    strokeWeight(1);
    line(5,130+i*80,width-7,130+i*80);
    line(5+i*67,110,5+i*67,610);
    line(5,110,width-7,110);
    fill(#041643);
    rect(5,110,width-2,20);
  }
   for (int z = 0; z < DAY.length; z = z + 1) {
    textSize (15);
    fill (0, 255, 255);
    text (DAY[z], z*68+20 , 125);
  }
  
  //移動
  textSize(22);
  strokeWeight(1);
  noStroke();
  fill(134, 214, 238);
  rect(10, 10, 20, 20);
  text("TOP", 65, 99);
  noFill();
  stroke(198, 238, 217);
  rect(50, 10, 20, 20);
  fill(198, 238, 217);
  text("CALENDAR", 105, 79);
  noStroke();
  fill(238, 238, 189);
  rect(90, 10, 20, 20);
  text("LECTURE", 145, 55);
  stroke(0);
  line(15, 30, 15, 90);
  line(15, 90, 60, 90);
  line(55, 30, 55, 70);
  line(55, 70, 100, 70);
  line(95, 30, 95, 50);
  line(95, 50, 140, 50);
}

/*3ページ*/
void page3(){
  font2=createFont("SansSerif.bold-48.vlw",48);
  background(255);
  textSize(35);
  text("Today's lecture",10,170);
  line(10,177,402,177);
  line(10,181,402,181);
  for(int sq=0;sq<5;sq++){
    stroke(250);
    rect(10+sq*76,220,70,37);
  }
  fill(188);
  textSize(23);
  text("MON",17,247);
  text("TUE",98,247);
  text("WED",174,247);
  text("THU",250,247);
  text("FRI",330,247);
  fill(0,255,0);
  textFont(font2);
  
  switch(lec){
    case 1://MON
    textSize(35);
    text("線形代数",10,300);
    text("コンピュータと教育",10,390);
    textSize(18);
    fill(0);
    text("9:00 - 10:30",10,325);
    text("13:10 - 14:40",10,415);
    break;
    
    case 2://TUE
    textSize(35);
    text("解析学",10,300);
    text("数学総合演習",10,390);
    textSize(18);
    fill(0);
    text("9:00 - 10:30",10,325);
    text("10:40 - 12:10",10,415);
    break;
    
    case 3://WED
    textSize(35);
    text("余暇と健康",10,300);
    text("Communication",10,390);
    text("環境と産業",10,480);
    text("認知科学",10,570);
    textSize(18);
    fill(0);
    text("10:40 - 12:10",10,325);
    text("13:10 - 14:40",10,415);
    text("14:50 - 16:20",10,505);
    text("16:30 - 18:00",10,595);
    break;
    
    case 4://THU
    textSize(35);
    text("情報表現入門",10,300);
    text("物理",10,390);
    textSize(18);
    fill(0);
    text("9:00 - 12:40 & 13:10 - 14:40",10,325);
    text("14:50 - 16:20",10,415);
    break;
    
    case 5://FRI
    textSize(35);
    text("科学技術リテラシ",10,300);
    text("Communication",10,390);
    text("情報機器概論",10,480);
    textSize(18);
    fill(0);
    text("10:40 - 12:10",10,325);
    text("13:10 - 14:40",10,415);
    text("14:50 - 16:20",10,505);
    break;
    
    default:
    break;
  }
  
  textFont(font1);
  //移動
  textSize(22);
  strokeWeight(1);
  noStroke();
  fill(134, 214, 238);
  rect(10, 10, 20, 20);
  text("TOP", 65, 99);
  noStroke();
  fill(198, 238, 217);
  rect(50, 10, 20, 20);
  fill(198, 238, 217);
  text("CALENDAR", 105, 79);
  noFill();
  stroke(238,238,189);
  rect(90, 10, 20, 20);
  fill(238,238,189);
  text("LECTURE", 145, 55);
  stroke(0);
  line(15, 30, 15, 90);
  line(15, 90, 60, 90);
  line(55, 30, 55, 70);
  line(55, 70, 100, 70);
  line(95, 30, 95, 50);
  line(95, 50, 140, 50);
}
    
void mousePressed() { //曜日の切り替え
  if(mouseY > 220 && mouseY < 257){
    if(mouseX > 10 && mouseX < 80){ //MON
      lec = 1;
    } if(mouseX > 86 && mouseX < 156){ //TUE
      lec = 2;
    } if(mouseX > 162 && mouseX < 232){ //WED
      lec = 3;
    } if(mouseX > 238 && mouseX < 308){ //THU
      lec = 4;
    } if(mouseX > 314 && mouseX < 384){ //FRI
      lec = 5;
    }
  }
}

void draw(){
  /*最初のページ*/
  page1();
  
  switch(page){
    case 1:
    page1();
    break;
    case 2:
    page2();
    break;
    case 3:
    page3();
    break;
    default:
    break;
  }
}