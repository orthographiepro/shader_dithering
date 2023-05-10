#version 120

uniform sampler2D lightmap;
uniform sampler2D texture;
uniform vec4 entityColor;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

uniform vec3 dark_color;
uniform vec3 light_color;

mat4 dithering_core = mat4(
		1.0 , 13.0, 4.0, 16.0, 
		9.0, 5.0, 12.0, 8.0,
		3.0, 15.0, 2.0, 14.0,
		11.0, 7.0, 10.0, 6.0
	) / 16.0;

void main() {
	vec4 color = texture2D(texture, texcoord) * glcolor;
	color.rgb = mix(color.rgb, entityColor.rgb, entityColor.a);
	color *= texture2D(lightmap, lmcoord);

	float luminance = color.x * 0.3 + color.y * 0.5 + color.z * 0.2;

	ivec2 coordinates = ivec2(gl_FragCoord.xy);
	coordinates.x = 
	float dithering_threshold = dithering_core[(coordinates.x % 16) / 4][coordinates.y % 4];
	
	color = vec4(light_color, 1.0); 
	if (luminance < dithering_threshold) color = vec4(dark_color, 1.0);


/* DRAWBUFFERS:0 */
	gl_FragData[0] = color; //gcolor
}