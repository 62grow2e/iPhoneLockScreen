class iOS7 {
	int w, h;
	PFont font;
	String time, date, pw_text, leftBottom, rightBottom;
	String[] unlock_text, alphabets;

	PGraphics lockScreen;
	PImage bg;
	int bg_gray, bg_alpha;

	int left_x;
	final int left_y = 0;

	int releasedLeft_x = left_x;

	boolean isEasing = false;
	boolean isLockScreen = true;
	boolean isTouched = false;
	boolean isTouchHeld = false;
	boolean isDragged = false;
	boolean isDragReleased = false;
	boolean isLockLeft = true;

	int dragVelocity;
	float k_forDrag;

	int elapsedTime_released;
	float unlock_text_t;
	int[] unlock_text_alpha;

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
		leftBottom = "緊急";
		rightBottom = "キャンセル";
		unlock_text = new String[]{
			"〉", "ス", "ラ", "イ", "ド", "で", "ロ", "ッ", "ク", "解", "除"
		};
		alphabets = new String[]{
			"ABC", "DEF", "GHI", "JKL", "MNO", "PQRS", "TUV", "WXYZ"
		};

		bg = loadImage("bg_bar.jpg");
		bg_gray = 50;
		bg_alpha = 0;
		unlock_text_t = 0;
		unlock_text_alpha = new int[]{
			50, 50, 50, 120, 200, 255, 200, 120, 50, 50, 50
		};

		lockScreen = createGraphics(w*2, h);
		lockScreen.beginDraw();
		lockScreen.smooth();
		lockScreen.textFont(font);
		lockScreen.endDraw();
		left_x = -w;

		k_forDrag = 0.4;
		dragVelocity = 0;
		elapsedTime_released = 0;

		easing = new Easing();
		progress_t = 0;

	}

	void draw(){
		background(bg);
		fill(bg_gray, bg_alpha);
		noStroke();
		rect(0, 0, w, h);

		update();
		image(getScreen(), left_x, left_y, lockScreen.width, lockScreen.height);
	}

	void update(){
		if(!isDragged && !isEasing && !isTouched && !isTouchHeld && isLockScreen){
			elapsedTime_released++;
			if(elapsedTime_released > 200)isLockLeft = true;
		}
		if(isDragged && isLockScreen){
			left_x += ((dragVelocity < 0)?k_forDrag: 1)*(mouseX - pmouseX);
		}
		if(isDragged && !isLockScreen){
			left_x += ((dragVelocity > 0)?k_forDrag: 1)*(mouseX - pmouseX);
		}
		if(isTouchHeld && isLockScreen){
			left_x = easing.getX_linear(-w, int(-w*.9), progress_t);
			progress_t += (float)1/8;
			if(progress_t > 1)isTouchHeld = false;
		}
		if(isTouched && mouseX == pmouseX && left_x == -w){
			isTouched = false;
			isTouchHeld = true;
			progress_t = 0;
		}

		if(isEasing && isLockScreen){
			if(releasedLeft_x < -w*.6){
				left_x = easing.getX_linear(releasedLeft_x, -w, progress_t);
				progress_t += (float)1/8;
				if(progress_t > 1)isEasing = false;
			}
			else if(releasedLeft_x >= -w*.6){
				left_x = easing.getX_linear(releasedLeft_x, 0, progress_t);
				progress_t += (float)1/8;
				if(progress_t > 1){
					isEasing = false;
					isLockScreen = false;
				}
			}
		}
		if(isEasing && !isLockScreen){
			if(dragVelocity < -5){
				left_x = easing.getX_linear(releasedLeft_x, -w, progress_t);
				progress_t += (float)1/16;
				if(progress_t > 1){
					isEasing = false;
					isLockScreen = true;
				}
			}
			else {
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
		}
		int _left_x = (left_x < -w)? -w: (left_x > 0)? 0: left_x;
		bg_alpha = (int)map(_left_x, -w, 0, 0, 250);
		if(isLockLeft){
			unlock_text_t += (float)1/8;
			if(!isLockScreen)isLockLeft = false;
		}
		if(isDragReleased)isDragReleased = false;
	}

	PGraphics getScreen(){
		lockScreen.beginDraw();
		lockScreen.background(255, 0);
		lockScreen.textAlign(CENTER, CENTER);
		lockScreen.fill(255);
		lockScreen.textSize(h/8);
		lockScreen.text(time, lockScreen.width/4*3, h/8);
		lockScreen.textSize(h/36);
		lockScreen.text(date, lockScreen.width/4*3, h/5);
		lockScreen.textSize(h/30);
		lockScreen.text(pw_text, lockScreen.width/4, h/9);
		lockScreen.textAlign(LEFT, CENTER);
		lockScreen.text(leftBottom, w*.1, h*.95);
		lockScreen.textAlign(RIGHT, CENTER);
		lockScreen.text(rightBottom, w*.9, h*.95);
		lockScreen.noFill();
		lockScreen.stroke(255, 200);
		lockScreen.strokeWeight(1);
		for (int i = 0; i < 4; i++){
			lockScreen.ellipse(w/9*(i+3), h/6, 15, 15);
		}
		lockScreen.textAlign(CENTER, CENTER);
		for(int i = 0; i < 12; i++){
			if(i == 9 || i == 11)continue;
			lockScreen.noFill();
			lockScreen.ellipse((i%3)*((float)w*.9/3)+.20*w, i/3*h/6.5 + h/3, w/4.14, w/4.14);
			lockScreen.fill(255);
			lockScreen.textSize(w/9);
			lockScreen.text((i != 10)?str(i+1): str(0), (i%3)*((float)w*.9/3)+.20*w, i/3*h/6.5 + h/3- ((i != 10)?10: 0));
			if(1<=i && i <= 8){
				lockScreen.textSize(h/50);
				lockScreen.text(alphabets[i-1], (i%3)*((float)w*.9/3)+.20*w, i/3*h/6.5 + h/3+20);
			}
		}
		if(isLockLeft){
			lockScreen.textSize(w/15);
			for(int i = 0; i < unlock_text.length; i++){
				int _i = ((int)(unlock_text_t - i + unlock_text.length)%unlock_text.length)%unlock_text.length;
				lockScreen.fill(255, unlock_text_alpha[_i]);
				lockScreen.text(unlock_text[i], i*w*.9/unlock_text.length + w*1.1, h*.9);
			}
		}
		lockScreen.endDraw();
		return lockScreen;
	}

	void mouseDragged(){
		isTouched = false;
		isTouchHeld = false;
		if(!isDragged)dragVelocity = mouseX - pmouseX;
		isDragged = true;

	}

	void mousePressed(){
		if(isLockScreen)isTouched = true;
	}

	void mouseReleased(){
		isDragged = false;
		isTouched = false;
		isTouchHeld = false;
		isDragReleased = true;
		isEasing = true;
		releasedLeft_x = left_x;
		dragVelocity = mouseX - pmouseX;
		progress_t = 0;
		elapsedTime_released = 0;
	}

	class Easing{
		int getX_linear(int from_x, int to_x, float t){
			// t must be no more than 1 and no less than 0
			if(t < 0 || 1 < t)return -1;
			return int(t*(to_x - from_x) + from_x);
		}

		int getX_damping(int from_x, int to_x, float t){
			// t must be no more than 1 and no less than 0
			if(t < 0 || 1 < t)return -1;
			return int(0);
		}
	}

}
