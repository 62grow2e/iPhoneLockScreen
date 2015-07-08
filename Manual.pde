class Manual{

	Manual(){
	}
	void draw(){
		textFont(notofont);

		background(#2288dd);
		fill(255);
		stroke(255);
		strokeWeight(3);
		textAlign(CENTER, CENTER);
		textSize(30);
		text("imitation of unlock screen", width/2, height/10);
		textSize(25);
		text("iOS 7.0 or later version", width/2, 2*height/10);

		line(width/8, 3*height/10, 7*width/8, 3*height/10);
		
		textAlign(LEFT);
		textSize(17);
		text("[SPACE]: マニュアルと実行画面の切り替え", width/10, 4*height/10);
		text("タッチイベントはドラッグで実装しています。\nドラッグして操作してください。", width/10, 5*height/10);
		
		text("フォント著作権:", width/10, 6.5*height/10);
		textSize(12);
		text("Noto Fonts (c) Google Inc. Licensed under Apache License 2.0", width/10, 7*height/10);
	}

}