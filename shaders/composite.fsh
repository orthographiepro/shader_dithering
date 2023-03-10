#version 120

uniform sampler2D colortex1;
uniform sampler2D gcolor;

varying vec2 texcoord;

vec3 dark = vec3(0.19, 0.23, 0.15);
vec3 light = vec3(1.0, 1.0, 1.0);

void main() {

	vec3 color = texture2D(gcolor, texcoord).rgb;
	float luminance = color.x * 0.3 + color.y * 0.5 + color.z * 0.2;

	ivec2 fragment_location = ivec2(vec2(textureSize(gcolor, 0)) * texcoord);
	
	float dithering_threshold = texture(colortex1, vec2(fragment_location%512)/512.0).x;

	color = light; 
	if (luminance < dithering_threshold) color = dark;	

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}