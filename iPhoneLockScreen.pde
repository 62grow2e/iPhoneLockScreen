
Version version;
iOS7 ios7;
void setup(){
	version = Version.PLAY;
	size(414, 736);
	ios7 = new iOS7(width, height);
}

void draw(){
	if(version == Version.PLAY)ios7.draw();
	
}

void mouseDragged(){
	if(version == Version.PLAY)ios7.mouseDragged();
}

void mouseReleased(){
	if(version == Version.PLAY)ios7.mouseReleased();
}

void mousePressed(){
	if(version == Version.PLAY)ios7.mousePressed();
}

void keyPressed(){
	if(version == Version.PLAY)version = Version.MANUAL;
	if(version == Version.MANUAL)version = Version.PLAY;
}