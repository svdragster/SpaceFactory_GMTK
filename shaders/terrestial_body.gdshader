// Based on: https://www.reddit.com/r/godot/comments/gqhy3g/procedural_planet_generator_based_on_planetarium/
shader_type spatial;

uniform bool emit = false;
uniform vec4 color_1 : source_color = vec4(0.17, 0.55, 1.0, 1.0);
uniform float color_1_treshold : hint_range(0, 1) = 0.54;
uniform float color_1_roughness : hint_range(0, 1) = 0.1;
uniform float color_1_specular : hint_range(0, 1) = 1.0;
uniform float color_1_metallic : hint_range(0, 1) = 0.7;
uniform bool color_1_emit = false;
uniform vec4 color_2 : source_color = vec4(1.0, 0.94, 0.76, 1.0);
uniform float color_2_treshold : hint_range(0, 1) = 0.56;
uniform vec4 color_3 : source_color = vec4(0.34, 0.74, 0.5, 1.0);
uniform float color_3_treshold : hint_range(0, 1) = 0.6;
uniform vec4 color_4 : source_color = vec4(0.27, 0.62, 0.42, 1.0);
uniform float color_4_treshold : hint_range(0, 1) = 0.7;
uniform vec4 color_5 : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float color_5_treshold : hint_range(0, 1) = 1.0;
uniform bool noise_gaseous = false;
uniform float noise_gaseous_speed : hint_range(0, 0.1) = 0.0025;
uniform float noise_scale : hint_range(1, 10) = 1.0;
uniform sampler2D noise : hint_default_black;
uniform sampler2D noise_normal : hint_default_black;
uniform float noise_normal_depth = 10.0;
uniform sampler2D water_noise_normal : hint_default_black;
uniform float water_speed : hint_range(0.0, 1.0) = 0.004;
uniform float noise_normal_depth_water = 0.6;
uniform float ice_cap_size : hint_range(0.0, 0.5) = 0.04;

varying vec3 triplanar_power_normal;
varying vec3 triplanar_pos;

const float triplanar_sharpness = 0.5;

vec2 rotate_position(vec2 position) {
	if (noise_gaseous) {
		position = mod(position + TIME * 2.5 * noise_gaseous_speed / 10.0, 0.0);
	}
	return position;
}

vec4 triplanar_texture(sampler2D p_sampler, vec3 p_weights, vec3 p_triplanar_pos) {
	vec4 samp = vec4(0.0);
	samp += texture(p_sampler, rotate_position(p_triplanar_pos.xy)) * p_weights.z;
	samp += texture(p_sampler, rotate_position(p_triplanar_pos.xz)) * p_weights.y;
	samp += texture(p_sampler, rotate_position(p_triplanar_pos.zy * vec2(-1.0, 1.0))) * p_weights.x;
	return samp;
}

void vertex() {
	triplanar_power_normal = pow(abs(NORMAL), vec3(triplanar_sharpness));
	triplanar_power_normal /= dot(triplanar_power_normal, vec3(1.0));
	triplanar_pos = VERTEX * vec3(noise_scale, noise_scale, noise_scale);
	triplanar_pos *= vec3(1.0, -1.0, 1.0);
}

void fragment() {
	vec3 triplanar_pos_clone = triplanar_pos;
	if (noise_gaseous) {
		triplanar_pos_clone = vec3(triplanar_pos.x * sin(0.1), triplanar_pos.y, triplanar_pos.z * sin(0.1));
	}
	vec4 color = triplanar_texture(noise, triplanar_power_normal, triplanar_pos_clone);
	vec4 normal = triplanar_texture(noise_normal, triplanar_power_normal, triplanar_pos_clone);
	float normal_depth = noise_normal_depth;
	float roughness = 0.0;
	float specular = 0.0;
	float metallic = 0.0;
	float d = max(max(color.r, color.g), color.b);
	if ((triplanar_pos_clone.y <= (-0.5 + ice_cap_size) + d * ice_cap_size || triplanar_pos_clone.y >= (0.5-ice_cap_size) - d * ice_cap_size)) {
		color = vec4(1.0, 1.0, 1.0, 1.0);
	} else if (d < color_1_treshold) {
		color = color_1;
		roughness = color_1_roughness;
		specular = color_1_specular;
		metallic = color_1_metallic;
		if (color_1_emit) {
			EMISSION = color_1.rgb;
		}
		if (water_speed > 0.0) {
			triplanar_pos_clone = vec3(triplanar_pos.x + TIME*water_speed, triplanar_pos.y, triplanar_pos.z + TIME*water_speed);
		}
		normal = triplanar_texture(water_noise_normal, triplanar_power_normal, triplanar_pos_clone);
		normal_depth = noise_normal_depth_water;
	}
	else if (d < color_2_treshold) {
		color = color_2;
	}
	else if (d < color_3_treshold) {
		color = color_3;
	}
	else if (d < color_4_treshold) {
		color = color_4;
	}
	else if (d < color_5_treshold) {
		color = color_5;
	}
	if(emit) {
		EMISSION = color.rgb;
	}
	NORMAL_MAP = normal.rgb;
	NORMAL_MAP_DEPTH = normal_depth;
	ALBEDO = color.rgb;
	ROUGHNESS = roughness;
	SPECULAR = specular;
	METALLIC = metallic;
}