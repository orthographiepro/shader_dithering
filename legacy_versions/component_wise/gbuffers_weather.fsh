#version 120

uniform sampler2D lightmap;
uniform sampler2D texture;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

uniform vec3 light_color;

void main() {
	
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color *= texture2D(lightmap, lmcoord);
	
	if (color.a > 0.5) color = vec4(light_color, 0.8);

/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}