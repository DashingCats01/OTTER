#version 420

layout(location = 0) in vec2 inUV;

out vec4 frag_color;

layout (binding = 0) uniform sampler2D s_screenTex;

uniform sampler2D scene;
uniform sampler2D bloomBlur;
uniform float exposure;

void main() 
{
	const float gamma = 2.2;
    vec3 hdrColor = texture(scene, inUV).rgb;      
    vec3 bloomColor = texture(bloomBlur, inUV).rgb;

    hdrColor += bloomColor; // additive blending
    // tone mapping
    vec3 result = vec3(1.0) - exp(-hdrColor * exposure);

    // also gamma correct while we're at it       
    result = pow(result, vec3(1.0 / gamma));
    frag_color = vec4(result, 1.0);
}