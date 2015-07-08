PFont notofont;
Mode mode;
iOS8_4 ios;
Manual manual;
void setup(){
	// load free font; noto font
	notofont = loadFont("NotoSansCJKjp-Thin-48.vlw");
	mode = Mode.MANUAL;
	size(414, 736);
	ios = new iOS8_4(width, height);
	manual = new Manual();
}

void draw(){
	switch (mode) {
		case PLAY :
		ios.update();
		image(ios.getBackground(), 0, 0, width, height);
		image(ios.getScreen(), ios.getScreenPos(), ios.getScreenSize());
		break;	
		case MANUAL :
		manual.draw();
		break;	
	}
}

void mouseDragged(){
	if(mode == Mode.PLAY)ios.mouseDragged();
}

void mouseReleased(){
	if(mode == Mode.PLAY)ios.mouseReleased();
}

void mousePressed(){
	if(mode == Mode.PLAY)ios.mousePressed();
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