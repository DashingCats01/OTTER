#version 420

layout(location = 0) in vec2 inUV;


out vec4 frag_color;

layout (binding = 0) uniform sampler2D s_screenTex;

uniform bool horizontal;
uniform float weight[5] = float[] (0.227027, 0.1945946, 0.1216216, 0.054054, 0.016216);

void main() 
{
	vec2 tex_offset = 1.0 /textureSize(s_screenTex, 0);
	vec3 result = texture(s_screenTex, inUV).rgb * weight[0];

	if (horizontal)
	{
		for (int i = 1; i <5; i++)
		{
			result += texture(s_screenTex, inUV + vec2(tex_offset.x * i, 0.0)).rgb * weight[i];
			result += texture(s_screenTex, inUV - vec2(tex_offset.x * i, 0.0)).rgb * weight[i];
		}
	}
	else
	{
		for (int i = 1; i <5; i++)
		{
			result += texture(s_screenTex, inUV + vec2(0.0, tex_offset.y * i)).rgb * weight[i];
			result += texture(s_screenTex, inUV - vec2(0.0, tex_offset.y * i)).rgb * weight[i];
		}
	}
	
	frag_color = vec4(result,1.0);
}