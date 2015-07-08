
Mode mode;
iOS7 ios7;
Manual manual;
void setup(){
	mode = Mode.MANUAL;
	size(414, 736);
	ios7 = new iOS7(width, height);
	manual = new Manual();
}

void draw(){
	switch (mode) {
		case PLAY :
			ios7.draw();
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