shader_type spatial;

uniform sampler2D tex;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 color = texture(tex, UV);
    ALBEDO = vec3(color.r * 2.0f, color.g, color.b);
    //ALPHA = 1.0f;
	ALBEDO = vec3(COLOR.r, COLOR.g, COLOR.b);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
