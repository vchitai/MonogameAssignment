#if OPENGL
	#define SV_POSITION POSITION
	#define VS_SHADERMODEL vs_3_0
	#define PS_SHADERMODEL ps_3_0
#else
	#define VS_SHADERMODEL vs_4_0_level_9_1
	#define PS_SHADERMODEL ps_4_0_level_9_1
#endif

matrix WorldViewProjection;

texture HinhTuSpriteBatch;

sampler TextureSampler = sampler_state
{
	Texture = <HinhTuSpriteBatch>;
};


texture Texture2;
sampler Texture2Sampler = sampler_state
{
	Texture = <Texture2>;
};



struct VertexShaderInput
{
	float4 Position : SV_POSITION;
	float4 Color : COLOR0;
};

struct VertexShaderOutput
{
	float4 Position : SV_POSITION;
	float4 Color : COLOR0;
};

VertexShaderOutput MainVS(in VertexShaderInput input)
{
	VertexShaderOutput output = (VertexShaderOutput)0;

	output.Position = mul(input.Position, WorldViewProjection);
	output.Color = input.Color;

	return output;
}

float4 MainPS(float2 texCoordinates: TEXCOORD0) : COLOR
{
//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1- (texCoordinates+1)/2;
	TextureCoordinates.x = 1-TextureCoordinates.x;
	float4 color;
	color = tex2D(TextureSampler, TextureCoordinates);
	return color;

}

technique BasicColorDrawing
{
	pass P0
	{
//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS();
	}
};

float4 MainPS1(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;
	float4 color;
	color = tex2D(TextureSampler, TextureCoordinates);
	color.rgb = color.r*0.3 + color.g*0.59 + color.b * 0.11;
	return color;

}


technique Technique01
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS1();
	}
};



float4 MainPS2(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;
	float4 color;
	color = tex2D(TextureSampler, TextureCoordinates);
	color.rgb = color.r*0.3 + color.g*0.59 + color.b * 0.11;
	color.r *= 1.1;
	color.g *= 1.2;
	color.b *= 0.8;
	return color;

}


technique Technique02
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS2();
	}
};

float t;


float4 MainPS3(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;

	

	float4 color;
	color = tex2D(TextureSampler, TextureCoordinates) +
		tex2D(TextureSampler, TextureCoordinates + float2(t, 0)) +
		tex2D(TextureSampler, TextureCoordinates + float2(-t, 0)) +
		tex2D(TextureSampler, TextureCoordinates + float2(0, t)) +
			tex2D(TextureSampler, TextureCoordinates + float2(0, -t));
	color /= 5;

	return color;

}


technique Technique03
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS3();
	}
};



float4 MainPS4(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;
	float4 color;
	color = float4(
		tex2D(TextureSampler, TextureCoordinates).r,
		tex2D(TextureSampler, TextureCoordinates + float2(0.01, 0)).gb, 
		1);

	return color;

}


technique Technique04
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS4();
	}
};



float4 MainPS5(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;
	float4 color;
	color =
		(
			 tex2D(TextureSampler, TextureCoordinates - float2(0.001, 0))
			-tex2D(TextureSampler, TextureCoordinates + float2(0.001, 0))
		) / 2 
			+ 0.5;

	color.r *= 1.2;
	color.g *= 1.1;
	color.b *= 0.8;
	color.a = 1;

	return color;

}


technique Technique05
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS5();
	}
};


float4 MainPS6(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;
	float4 color;
	float2 ModifiedTextureCoordinates = TextureCoordinates;
	ModifiedTextureCoordinates.x += 0.02*sin(25*ModifiedTextureCoordinates.y+t);
	ModifiedTextureCoordinates.y += 0.03*sin(25 * ModifiedTextureCoordinates.x + t*2);

	color = tex2D(TextureSampler, ModifiedTextureCoordinates);


	return color;

}


technique Technique06
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS6();
	}
};


float4 MainPS7(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;
	float4 color1, color2;

	color1 = tex2D(TextureSampler, TextureCoordinates);
	color2 = tex2D(Texture2Sampler, TextureCoordinates);

	float4 color;
	float tt = t;
	if (tt > 1) tt = 1;
	color = (1 - tt)*color2 + tt * color1;

	return color;

}


technique Technique07
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS7();
	}
};


float4 MainPS8(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;
	float4 color1, color2;

	color1 = tex2D(TextureSampler, TextureCoordinates);
	color2 = tex2D(Texture2Sampler, TextureCoordinates);

	float4 color;
	float w = TextureCoordinates.x + t;
	w = w % 1;
	color = (1 - w) * color1 + w * color2;

	return color;

}


technique Technique08
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS8();
	}
};

float x0, y0;

float4 MainPS9(float2 texCoordinates: TEXCOORD0) : COLOR
{
	//	return float4(1,0,0,1);
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;

	float2 ModifiedTextureCoordinates = TextureCoordinates - float2(x0, y0);
	float tt = t;
	if (t > 1) tt = 1;
	ModifiedTextureCoordinates.x /= tt;
	ModifiedTextureCoordinates.y /= tt;
	ModifiedTextureCoordinates += float2(x0, y0);
	float4 color1, color2;

	color1 = tex2D(TextureSampler, ModifiedTextureCoordinates);

	color2 = tex2D(TextureSampler, TextureCoordinates);

	float4 color;
	color = color2 + t*color1;
	color.a = 1;

	return color;

}


technique Technique09
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS9();
	}
};


float4 MainPS10(float2 texCoordinates: TEXCOORD0) : COLOR
{
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;

	float4 color1, color2;

	color1 = tex2D(TextureSampler, TextureCoordinates);

	color2 = tex2D(Texture2Sampler, TextureCoordinates);

	float4 color;
	if (TextureCoordinates.x >= 0.3 && TextureCoordinates.x <= 0.5
		&& TextureCoordinates.y >= 0.3 && TextureCoordinates.y <= 0.5)
		color = color1;
	else
		color = color2;

	return color;

}


technique Technique10
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS10();
	}
};


float4 MainPS11(float2 texCoordinates: TEXCOORD0) : COLOR
{
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;
	float2 ModifiedTextureCoordinates;
	ModifiedTextureCoordinates.x = TextureCoordinates.x * cos(t) - TextureCoordinates.y*sin(t);
	ModifiedTextureCoordinates.y = TextureCoordinates.x * sin(t) + TextureCoordinates.y*cos(t);

	float4 color1 = tex2D(TextureSampler, ModifiedTextureCoordinates);


	return color1;

}


technique Technique11
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS11();
	}
};



float4 MainPS12(float2 texCoordinates: TEXCOORD0) : COLOR
{
	float2 TextureCoordinates = 1 - (texCoordinates + 1) / 2;
	TextureCoordinates.x = 1 - TextureCoordinates.x;
	
	float2 ModifiedTextureCoordinates;
	ModifiedTextureCoordinates.x = TextureCoordinates.x+t;
	ModifiedTextureCoordinates.y = TextureCoordinates.y-t;

	float4 color1 = tex2D(TextureSampler, ModifiedTextureCoordinates);


	return color1;

}


technique Technique12
{
	pass P0
	{
		//		VertexShader = compile VS_SHADERMODEL MainVS();
		PixelShader = compile PS_SHADERMODEL MainPS12();
	}
};