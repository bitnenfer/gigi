// Unnamed technique, shader ifft_vertical
/*$(ShaderResources)*/

#include "fft_core.hlsl"

/*$(_compute:ifftVertical)*/(uint local_index : SV_GroupIndex, uint3 workgroup_id : SV_GroupID)
{
	fft(local_index, workgroup_id.x, 1, true);
}

/*
Shader Resources:
	Buffer FFTBuffer (as UAV)
*/
