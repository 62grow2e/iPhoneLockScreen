class iOS7 {
	int w, h;
	PFont font;
	String time, date, pw_text;

	PGraphics lockScreen;
	int bg_gray, bg_alpha;

	int left_x;
	final int left_y = 0;

	float k_forDrag;
	int releasedLeft_x = left_x;

	boolean isEasing = false;
	boolean isLockScreen = true;
	boolean isTouchedWithLockScreen = false;
	boolean isDragged = false;
	boolean isDragReleased = false;

	int dragReleaseVelocity;

	Easing easing;
	float progress_t;

	iOS7(int _width, int _height){
		w = _width;
		h = _height;

		// load free font
		font = loadFont("NotoSansCJKjp-Thin-48.vlw");
		// set date info
		time = "14:67";
		date = "1月17日(土曜日)";
		pw_text = "Touch IDまたはパスコードを入力";

		bg_gray = 50;
		bg_alpha = 0;

		lockScreen = createGraphics(w*2, h);
		left_x = -w;

		k_forDrag = 0.4;
		dragReleaseVelocity = 0;

		easing = new Easing();
		progress_t = 0;

	}

	void draw(){
		fill(bg_gray, bg_alpha);
		noStroke();
		rect(0, 0, w, h);

		update();
		image(getScreen(), left_x, left_y, lockScreen.width, lockScreen.height);
	}

	void update(){
		if(isDragged)left_x += k_forDrag*(mouseX - pmouseX);

		if(isEasing && isLockScreen){
			if(releasedLeft_x < -w/2){
				left_x = easing.getX_linear(releasedLeft_x, -w, progress_t);
				progress_t += (float)1/8;
				if(progress_t > 1)isEasing = false;
			}
			else if(releasedLeft_x >= -w/2){
				left_x = easing.getX_linear(releasedLeft_x, 0, progress_t);
				progress_t += (float)1/8;
				if(progress_t > 1){
					isEasing = false;
					isLockScreen = false;
				}
			}
		}
		if(isEasing && !isLockScreen){
			if(releasedLeft_x > -w/2){
				left_x = easing.getX_linear(releasedLeft_x, 0, progress_t);
				progress_t += (float)1/8;
				if(progress_t > 1)isEasing = false;
			}
			else if(releasedLeft_x <= -w/2){
				left_x = easing.getX_linear(releasedLeft_x, -w, progress_t);
				progress_t += (float)1/8;
				if(progress_t > 1){
					isEasing = false;
					isLockScreen = true;
				}
			}
		}

		int _left_x = (left_x < -w)? -w: (left_x > 0)? 0: left_x;
		bg_alpha = (int)map(_left_x, -w, 0, 0, 250);

		if(isDragReleased)isDragReleased = false;
	}

	PGraphics getScreen(){
		lockScreen.beginDraw();
		lockScreen.textFont(font);
		lockScreen.background(255, 0);
		lockScreen.textAlign(CENTER, CENTER);
		lockScreen.fill(255);
		lockScreen.textSize(h/8);
		lockScreen.text(time, lockScreen.width/4*3, h/8);
		lockScreen.textSize(h/36);
		lockScreen.text(date, lockScreen.width/4*3, h/5);
		lockScreen.textSize(h/30);
		lockScreen.text(pw_text, lockScreen.width/4, h/9);
		lockScreen.noFill();
		lockScreen.stroke(255, 200);
		lockScreen.strokeWeight(1);
		for (int i = 0; i < 4; i++){
			lockScreen.ellipse(w/9*(i+3), h/6, 15, 15);
		}
		lockScreen.textSize(w/9);
		for(int i = 0; i < 12; i++){
			if(i == 9 || i == 11)continue;
			lockScreen.noFill();
			lockScreen.ellipse((i%3)*((float)w*.9/3)+.20*w , i/3*h/6.5 + h/3, w/4.14, w/4.14);
			lockScreen.fill(255);
			lockScreen.text((i != 10)?str(i+1): str(0), (i%3)*((float)w*.9/3)+.20*w , i/3*h/6.5 + h/3- ((i != 10)?w/41.4: 0));
		}
		lockScreen.endDraw();
		return lockScreen;
	}

	void mouseDragged(){
		isDragged = true;
	}

	void mousePressed(){
		if(isLockScreen){
			//isEasing = true;
			isTouchedWithLockScreen = true;
			progress_t = 0;
		}
	}

	void mouseReleased(){
		if(isDragged){
			isDragReleased = true;
			isEasing = true;
			releasedLeft_x = left_x;
			dragReleaseVelocity = mouseX - pmouseX;
			progress_t = 0;
		}
		isDragged = false;
	}

	class Easing{
		int getX_linear(int from_x, int to_x, float t){
			// t must be no more than 1 and no less than 0
			if(t < 0 || 1 < t)return -1;
			return int(t*(to_x - from_x) + from_x);
		}
	}

}
