// Unnamed technique, shader ModelViewerVS
/*$(ShaderResources)*/

struct VSInput
{
	float3 Position   : POSITION;
	uint   VertexID   : SV_VertexID;
	uint   InstanceId : SV_InstanceID;
	float3 Color      : COLOR;
	float3 Normal     : NORMAL;
	float4 Tangent    : TANGENT;
	float2 UV         : TEXCOORD0;
	int MaterialID    : TEXCOORD1;
	int ShapeID       : TEXCOORD2;
};

struct VSOutput // AKA PSInput
{
	float4 Position   : SV_POSITION;
	float4 Color      : TEXCOORD0;
};

VSOutput vsmain(VSInput input)
{
	float4 outPos = mul(float4(input.Position, 1.0f), /*$(Variable:ViewProjMtx)*/);

	VSOutput ret = (VSOutput)0;
	switch(/*$(Variable:ViewMode)*/)
	{
		case ViewModes::InputPos: ret.Color = float4(input.Position, 1.0f); break;
		case ViewModes::OutputPos: ret.Color = float4(outPos / outPos.w); break;
		case ViewModes::VertexID: ret.Color = float4(input.VertexID, 0.0f, 0.0f, 1.0f); break;
		case ViewModes::InstanceID: ret.Color = float4(input.InstanceId, 0.0f, 0.0f, 1.0f); break;
		case ViewModes::Color: ret.Color = float4(input.Color, 1.0f); break;
		case ViewModes::Normal: ret.Color = float4(input.Normal, 1.0f); break;
		case ViewModes::Tangent: ret.Color = float4(input.Tangent); break;
		case ViewModes::UV: ret.Color = float4(input.UV, 0.0f, 1.0f); break;
		case ViewModes::MaterialID: ret.Color = float4(input.MaterialID, 0.0f, 0.0f, 1.0f); break;
		case ViewModes::ShapeID: ret.Color = float4(input.ShapeID, 0.0f, 0.0f, 1.0f); break;
		case ViewModes::ViewerColor: ret.Color = /*$(Variable:ViewerColor)*/; break;
	}
	
	ret.Position = outPos;
	return ret;
}
