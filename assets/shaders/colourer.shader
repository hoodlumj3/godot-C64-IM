shader_type canvas_item;

// flash any pixel that colour value is FFFFFF

uniform int color0  : hint_range(0,15) = 2;
uniform int flash0  : hint_range(0,15) = 1;
uniform int color1  : hint_range(0,15) = 7;
uniform int color2  : hint_range(0,15) = 6;

vec4 pickColor(int aColor) {
	//aColor = 5;
	vec4 colout = vec4((float(aColor)/10.0),(float(aColor)/10.0),(float(aColor)/10.0),1.0);
	//return colout;
	if ( aColor == 0 ) {
			colout = vec4(float(0.0/255.0),float(0.0/255.0),float(0.0/255.0),1.0); // black
	}
	else 
	if ( aColor == 1 ) {
			colout = vec4(float(255.0/255.0),float(255.0/255.0),float(255.0/255.0),1.0); // White
	}
	else 
	if ( aColor == 2 ) {
			colout = vec4(float(137.0/255.0),float(64.0/255.0),float(54.0/255.0),1.0); // red
	}
	else 
	if ( aColor == 3 ) {
			colout = vec4(float(122.0/255.0),float(191.0/255.0),float(199.0/255.0),1.0); // Cyan
	}
	else 
	if ( aColor == 4 ) {
			colout = vec4(float(138.0/255.0),float(70.0/255.0),float(174.0/255.0),1.0); // Purple
	}
	else 
	if ( aColor == 5 ) {
			colout = vec4(float(104.0/255.0),float(169.0/255.0),float(65.0/255.0),1.0); // green
	}
	else 
	if ( aColor == 6 ) {
			colout = vec4(float(62.0/255.0),float(49.0/255.0),float(162.0/255.0),1.0); // Blue
	}
	else 
	if ( aColor == 7 ) {
			colout = vec4(float(208.0/255.0),float(220.0/255.0),float(113.0/255.0),1.0); // yellow
	}
	else 
	if ( aColor == 8 ) {
			colout = vec4(float(144.0/255.0),float(95.0/255.0),float(37.0/255.0),1.0); // Orange
	}
	else 
	if ( aColor == 9 ) {
			colout = vec4(float(92.0/255.0),float(71.0/255.0),float(0.0/255.0),1.0); // Brown
	}
	else 
	if ( aColor == 10 ) {
			colout = vec4(float(187.0/255.0),float(119.0/255.0),float(109.0/255.0),1.0); // Pink
	}
	else 
	if ( aColor == 11 ) {
			colout = vec4(float(85.0/255.0),float(85.0/255.0),float(85.0/255.0),1.0); // Dark Grey
	}
	else 
	if ( aColor == 12 ) {
			colout = vec4(float(171.0/255.0),float(171.0/255.0),float(171.0/255.0),1.0); // Grey
	}
	else 
	if ( aColor == 13 ) {
			colout = vec4(float(172.0/255.0),float(234.0/255.0),float(136.0/255.0),1.0); // Light Green
	}
	else 
	if ( aColor == 14 ) {
			colout = vec4(float(124.0/255.0),float(112.0/255.0),float(218.0/255.0),1.0); // Light Blue
	}
	else 
	if ( aColor == 15 ) {
			colout = vec4(float(187.0/255.0),float(187.0/255.0),float(187.0/255.0),1.0); // Light Grey
	}

	return (colout);
}

void fragment() {
	float time = fract(TIME);
	vec4 col1 = texture(TEXTURE, UV);
	vec4 colout = col1;
	//vec4 col = col1;
	if ( col1 == pickColor(1) ) { //col1.a == 1.0 && col1.r >= 0.98 && col1.g >= 0.98 && col1.b >= 0.98) {
		//col = texture(TEXTURE, UV);
		//col1 = vec4(1.0-time/1.0,1.0-time/1.0,1.0-time/1.0,1.0);
		//colout = vec4(col1.r,col1.g,col1.b,1.0-time/1.0);
		colout = pickColor(color0);
		int a = int(time*100.0)/50;
		if ( a == 0 ) colout = pickColor(flash0);
	}
	if ( col1 == pickColor(11) ) {
		//colout = vec4(float(208.0/255.0),float(220.0/255.0),float(113.0/255.0),1.0); // yellow
		//colout = vec4(float(124.0/255.0),float(112.0/255.0),float(218.0/255.0),1.0); // Light Blue
		//color1 = 4;
		colout = pickColor(color1);
		//colout = vec4(1.0, 0.5, 0.0,1.0);
	}
	if ( col1 == pickColor(0) ) {
		//colout = vec4(1.0,1.0,0.0,1.0);
		//colout = vec4(float(0.0/255.0),float(0.0/255.0),float(0.0/255.0),1.0); // black
		//colout = vec4(float(255.0/255.0),float(255.0/255.0),float(255.0/255.0),1.0); // White
		//colout = vec4(float(137.0/255.0),float(64.0/255.0),float(54.0/255.0),1.0); // red
		//colout = vec4(float(122.0/255.0),float(191.0/255.0),float(199.0/255.0),1.0); // Cyan
		//colout = vec4(float(138.0/255.0),float(70.0/255.0),float(174.0/255.0),1.0); // Purple
		//colout = vec4(float(104.0/255.0),float(169.0/255.0),float(65.0/255.0),1.0); // green
		//colout = vec4(float(62.0/255.0),float(49.0/255.0),float(162.0/255.0),1.0); // Blue
		//colout = vec4(float(208.0/255.0),float(220.0/255.0),float(113.0/255.0),1.0); // yellow
		//colout = vec4(float(144.0/255.0),float(95.0/255.0),float(37.0/255.0),1.0); // Orange
		//colout = vec4(float(92.0/255.0),float(71.0/255.0),float(0.0/255.0),1.0); // Brown
		//colout = vec4(float(187.0/255.0),float(119.0/255.0),float(109.0/255.0),1.0); // Pink
		//colout = vec4(float(85.0/255.0),float(85.0/255.0),float(85.0/255.0),1.0); // Dark Grey
		//colout = vec4(float(171.0/255.0),float(171.0/255.0),float(171.0/255.0),1.0); // Grey
		//colout = vec4(float(172.0/255.0),float(234.0/255.0),float(136.0/255.0),1.0); // Light Green
		//colout = vec4(float(124.0/255.0),float(112.0/255.0),float(218.0/255.0),1.0); // Light Blue
		//colout = vec4(float(187.0/255.0),float(187.0/255.0),float(187.0/255.0),1.0); // Light Grey
		colout = pickColor(color2);


	}
	
	COLOR = colout;
	//COLOR = tex(frame1, UV);
}