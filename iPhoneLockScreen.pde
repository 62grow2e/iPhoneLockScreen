PFont notofont;
Mode mode;
iOS7 ios7;
Manual manual;
void setup(){
	// load free font; noto font
	notofont = loadFont("NotoSansCJKjp-Thin-48.vlw");
	mode = Mode.MANUAL;
	size(414, 736);
	ios7 = new iOS7(width, height);
	manual = new Manual();
}

void draw(){
	switch (mode) {
		case PLAY :
		ios7.update();
		image(ios7.getBackground(), 0, 0, width, height);
		image(ios7.getScreen(), ios7.getScreenPos(), ios7.getScreenSize());
		break;	
		case MANUAL :
		manual.draw();
		break;	
	}
}

void mouseDragged(){
	if(mode == Mode.PLAY)ios7.mouseDragged();
}

void mouseReleased(){
	if(mode == Mode.PLAY)ios7.mouseReleased();
}

void mousePressed(){
	if(mode == Mode.PLAY)ios7.mousePressed();
}

void keyPressed(){
	switch (mode) {
		case PLAY :
		mode = Mode.MANUAL;
		break;	
		case MANUAL :
		mode = Mode.PLAY;
		break;	
	}
}

void image(PImage img, PVector pos, PVector size){
	image(img, pos.x, pos.y, size.x, size.y);
}