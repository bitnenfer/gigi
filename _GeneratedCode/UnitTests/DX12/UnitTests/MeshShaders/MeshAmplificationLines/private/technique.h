#pragma once

#include <d3d12.h>
#include <array>
#include <vector>
#include <unordered_map>
#include "DX12Utils/dxutils.h"

namespace MeshAmplificationLines
{
    using uint = unsigned int;
    using uint2 = std::array<uint, 2>;
    using uint3 = std::array<uint, 3>;
    using uint4 = std::array<uint, 4>;

    using int2 = std::array<int, 2>;
    using int3 = std::array<int, 3>;
    using int4 = std::array<int, 4>;
    using float2 = std::array<float, 2>;
    using float3 = std::array<float, 3>;
    using float4 = std::array<float, 4>;
    using float4x4 = std::array<std::array<float, 4>, 4>;

    struct ContextInternal
    {
        ID3D12QueryHeap* m_TimestampQueryHeap = nullptr;
        ID3D12Resource* m_TimestampReadbackBuffer = nullptr;

        static ID3D12CommandSignature* s_commandSignatureDispatch;

        struct Struct__MeshShaderCB
        {
            float AmplificationSpacing = 2.000000f;
            float3 _padding0 = {0.0f,0.0f,0.0f};  // Padding
            float4x4 ViewProjMtx = {1.0f, 0.0f, 0.0f, 0.0f,   0.0f, 1.0f, 0.0f, 0.0f,   0.0f, 0.0f, 1.0f, 0.0f,   0.0f, 0.0f, 0.0f, 1.0f};
        };

        struct Struct__AmplificationShaderCB
        {
            uint AmplificationCount = 4;
            float3 Offset = {0.0f, 1.0f, 0.0f};
        };

        Struct__MeshShaderCB constantBuffer__MeshShaderCB_cpu;
        ID3D12Resource* constantBuffer__MeshShaderCB = nullptr;

        Struct__AmplificationShaderCB constantBuffer__AmplificationShaderCB_cpu;
        ID3D12Resource* constantBuffer__AmplificationShaderCB = nullptr;

        ID3D12PipelineState* drawCall_Rasterize_pso = nullptr;
        ID3D12RootSignature* drawCall_Rasterize_rootSig = nullptr;

        std::unordered_map<DX12Utils::SubResourceHeapAllocationInfo, int, DX12Utils::SubResourceHeapAllocationInfo> m_RTVCache;
        std::unordered_map<DX12Utils::SubResourceHeapAllocationInfo, int, DX12Utils::SubResourceHeapAllocationInfo> m_DSVCache;

        // Freed on destruction of the context
        std::vector<ID3D12Resource*> m_managedResources;
    };
};
