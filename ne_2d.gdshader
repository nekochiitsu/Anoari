shader_type canvas_item;

uniform sampler2D NOISE;
uniform sampler2D Layer0;
uniform sampler2D Layer1;
uniform sampler2D Layer2;

// uniform float y_factor;     // Use -(noise_factor - 1) + 1
uniform float noise_factor;// Use -(  y_factor   - 1) + 1
uniform float resolution;
uniform float layer_count;

void fragment() {
	// float noise_factor   = (-1. + sin(TIME / 1.)) * .5;
	float y_factor       = -(noise_factor - 1.) + 1.;
	vec2 PIXELISED_UV    = vec2(ivec2(UV * resolution)) / resolution;
	float terrain        = texture(NOISE, PIXELISED_UV).r * noise_factor;
	terrain              = PIXELISED_UV.y * y_factor + terrain;
	terrain              = float(int(layer_count * terrain));
	// vec4 terrain_preview = vec4(1., 1., 1., 1.);
	// terrain_preview.a    = float(int(layer_count * terrain)) / layer_count;
	if (terrain == layer_count-2.)
		COLOR = texture(Layer2, PIXELISED_UV);
	else if (terrain == layer_count-1.)
		COLOR = texture(Layer1, PIXELISED_UV);
	else
		COLOR = texture(Layer0, PIXELISED_UV);
}
