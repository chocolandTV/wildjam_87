shader_type canvas_item;

uniform float shrink_factor : hint_range(0.0, 1.0);
uniform vec4 original_color : source_color;

void fragment() {
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE;
    vec4 color = original_color;

    // Calculate the shrinking effect based on the shrink factor
    float scale = 1.0 - shrink_factor;
    vec2 offset = (uv - 0.5) * scale + 0.5;

    // Apply the color with the shrinking effect
    COLOR = texture(TEXTURE, offset) * color;
}