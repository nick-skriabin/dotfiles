// Subtle grain / rough surface shader for Ghostty
// Adds a gentle film-grain noise overlay to the terminal

// Hash-based pseudo-random noise — fast and good enough for grain
float hash(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord.xy / iResolution.xy;

    // Sample the terminal texture
    vec4 color = texture(iChannel0, uv);

    // Generate static grain noise — same pattern every frame
    float grain = hash(fragCoord) * 2.0 - 1.0;

    // Intensity of the grain effect — keep it subtle!
    float intensity = 0.035;

    // Apply grain as additive noise
    color.rgb += grain * intensity;

    fragColor = color;
}
