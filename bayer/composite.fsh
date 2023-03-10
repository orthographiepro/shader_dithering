#version 120
#undef SIZE_4

uniform sampler2D gcolor;

varying vec2 texcoord;

#ifdef SIZE_4
	mat4 dithering_core = mat4(
		1.0 , 13.0, 4.0, 16.0, 
		9.0, 5.0, 12.0, 8.0,
		3.0, 15.0, 2.0, 14.0,
		11.0, 7.0, 10.0, 6.0
	) / 16.0;
#else 
	mat2 dithering_core = mat2(
		1.0, 3.0,
		4.0, 2.0
	) / 4.0;
#endif

vec3 dark = vec3(0.19, 0.23, 0.15);
vec3 light = vec3(1.0, 1.0, 1.0);

void main() {

	
	
	vec3 color = texture2D(gcolor, texcoord).rgb;
	float luminance = color.x * 0.3 + color.y * 0.5 + color.z * 0.2;
	ivec2 dimensions = ivec2(vec2(textureSize(gcolor, 0)) * texcoord);

	float dithering_threshold = 0.3;

	#ifdef SIZE_4
		dithering_threshold = dithering_core[(dimensions.x % 16) / 4][dimensions.y % 4];
	#else 
		dithering_threshold = dithering_core[(dimensions.x % 4) / 2][dimensions.y % 2];
	#endif

	color = light; 
	if (luminance < dithering_threshold) color = dark;	

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color , 1.0); //gcolor
}