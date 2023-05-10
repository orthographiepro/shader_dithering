#version 120

uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D gcolor;

uniform float viewWidth;
uniform float viewHeight;

in vec3 vaPosition;
in vec4 vaColor;
uniform vec3 cameraPosition;

varying vec2 texcoord;

vec3 dark = vec3(0.19, 0.23, 0.15);
vec3 light = vec3(1.0, 1.0, 1.0);

void main() {

	vec3 color = texture2D(gcolor, texcoord).rgb;
	float luminance = color.r * 0.21 + color.g * 0.72 + color.b * 0.07;

	
	float x_offset = (viewWidth) * (acos(normalize(vaPosition - cameraPosition).x)/(3.14159));
	float y_offset = (viewHeight) * (acos(normalize(vaPosition - cameraPosition).y)/(3.14159));
	vec2 offset_position = vec2(mod(gl_FragCoord.x + x_offset, viewWidth), mod(gl_FragCoord.y + y_offset, viewHeight));
	vec2 fragment_location = vec2(ivec2(offset_position) % 512) / 512.0; 
	
	float dithering_threshold = texture(colortex2, offset_position / vec2(viewWidth, viewHeight)).x;

	color = light; 
	if (luminance < dithering_threshold) color = dark;	

/* DRAWBUFFERS:0 */
	gl_FragData[0] = vec4(color, 1.0); //gcolor
}