shader_type canvas_item;

uniform float streak_count : hint_range(1.0, 64.0, 1.0) = 20.0;
uniform float streak_width : hint_range(0.01, 0.5, 0.01) = 0.06; // apparent angular width
uniform float speed : hint_range(-8.0, 8.0, 0.1) = 1.0;
uniform float intensity : hint_range(0.0, 4.0, 0.1) = 1.2;
uniform vec4 streak_color : source_color = vec4(1.0,1.0,1.0,1.0);
uniform float inner_cutoff : hint_range(0.0, 1.0, 0.01) = 0.12; // no streaks inside this radius (0..0.5)
uniform float outer_falloff : hint_range(0.0, 1.0, 0.01) = 0.95; // reduce near texture edge

void fragment() {
    // UV centered on sprite
    vec2 uv = UV - vec2(0.5);
    float r = length(uv); // 0 .. ~0.5 for typical sprite
    float a = atan(uv.y, uv.x); // -PI..PI

    // rotating angle offset by global time
    float t = TIME * speed;

    // repeating stripe using angle
    // map angle to 0..1 per streak
    float per = (a + PI) / (2.0 * PI); // 0..1
    float stripes = fract(per * streak_count + t * 0.07); // shift a bit by time for variation

    // make a narrow band in each sector
    float center = 0.5;
    float dist = abs(stripes - center);
    // convert angular width to fraction-of-sector
    float half_width = streak_width * 0.5;
    float band = 1.0 - smoothstep(half_width, half_width + 0.02, dist); // sharp stripe

    // fade by radius (no streaks at very center and fade near edge)
    float radial_mask = smoothstep(inner_cutoff, inner_cutoff + 0.08, r) * (1.0 - smoothstep(outer_falloff, 0.5, r));

    // final stripe intensity modulated by cos to get softer edges per-lobe and time wobble
    float wobble = 0.5 + 0.5 * cos((per * streak_count) * 6.28318 + TIME * speed * 0.8);
    float stripe_val = band * radial_mask * wobble * intensity;

    // base texture (planet art)
    vec4 base = texture(TEXTURE, UV);

    // overlay color (use additive blending visually by just adding)
    vec4 add = streak_color * stripe_val;
    // preserve base alpha
    vec4 outc = base + add;
    outc.a = base.a;

    COLOR = outc;
}