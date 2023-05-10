#version 120

uniform sampler2D lightmap;
uniform sampler2D texture;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

uniform float viewHeight;
uniform float viewWidth;

uniform sampler2D colortex10;
uniform vec3 light_color;
uniform vec3 dark_color;

varying vec4 location;


void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color *= texture2D(lightmap, lmcoord);

	float luminance = color.x * 0.3 + color.y * 0.5 + color.z * 0.2;
	float dithering_threshold = texture(colortex10, (vec2(ivec2(gl_FragCoord.xy)%512)/512.0)).x;

	if (luminance < dithering_threshold) color = vec4(dark_color, 1.0);
	else color = vec4(light_color, 1.0); 

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}