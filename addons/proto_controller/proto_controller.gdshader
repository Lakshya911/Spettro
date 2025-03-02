shader_type spatial;
render_mode unshaded, depth_draw_opaque;

// Basic properties
uniform vec4 albedo : source_color = vec4(1.0);
uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;
uniform bool use_texture = false;

void fragment() {
    // Set the base color
    vec4 color = albedo;
    
    // Apply texture if enabled
    if (use_texture) {
        color *= texture(texture_albedo, UV);
    }
    
    // Apply the color
    ALBEDO = color.rgb;
    ALPHA = color.a;
    
    // Disable fog effect on this material
    FOG = vec4(0.0);
}