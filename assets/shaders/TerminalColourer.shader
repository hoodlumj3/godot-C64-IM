shader_type canvas_item;

// replace any specific matched pixel with another colour value 0-15

uniform int color0  : hint_range(0,15) = 2;
uniform int color1  : hint_range(0,15) = 4;

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

	if ( col1 == pickColor(1) ) {
		colout = pickColor(color0);
	}
	if ( col1 == pickColor(3) ) {
		colout = pickColor(color1);
	}
	
	COLOR = colout;
}