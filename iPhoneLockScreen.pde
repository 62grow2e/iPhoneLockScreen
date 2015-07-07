
Version version;
iOS7 ios7;
void setup(){
	version = Version.iOS_7;
	size(414, 736);
	ios7 = new iOS7(width, height);
}

void draw(){
	background(#2288ff);
	fill(#ff0000);
	ellipse(width/2, height/2, 200, 200);
	ios7.draw();
	
}

void mouseDragged(){
	ios7.mouseDragged();
}

void mouseReleased(){
	ios7.mouseReleased();
}

void mousePressed(){
	ios7.mousePressed();
}

void keyPressed(){

}