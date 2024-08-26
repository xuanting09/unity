// Compiled shader for Windows, Mac, Linux

//////////////////////////////////////////////////////////////////////////
// 
// NOTE: This is *not* a valid shader file, the contents are provided just
// for information and for debugging purposes only.
// 
//////////////////////////////////////////////////////////////////////////
// Skipping shader variants that would not be included into build of current scene.

Shader "UI/Default" {
Properties {
[PerRendererData]  _MainTex ("Sprite Texture", 2D) = "white" { }
 _Color ("Tint", Color) = (1.000000,1.000000,1.000000,1.000000)
 _StencilComp ("Stencil Comparison", Float) = 8.000000
 _Stencil ("Stencil ID", Float) = 0.000000
 _StencilOp ("Stencil Operation", Float) = 0.000000
 _StencilWriteMask ("Stencil Write Mask", Float) = 255.000000
 _StencilReadMask ("Stencil Read Mask", Float) = 255.000000
 _ColorMask ("Color Mask", Float) = 15.000000
[Toggle(UNITY_UI_ALPHACLIP)]  _UseUIAlphaClip ("Use Alpha Clip", Float) = 0.000000
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "CanUseSpriteAtlas"="true" "PreviewType"="Plane" }
 Pass {
  Name "Default"
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "CanUseSpriteAtlas"="true" "PreviewType"="Plane" }
  ZTest [unity_GUIZTestMode]
  ZWrite Off
  Cull Off
  Stencil {
   Ref [_Stencil]
   ReadMask [_StencilReadMask]
   WriteMask [_StencilWriteMask]
   Comp [_StencilComp]
   Pass [_StencilOp]
  }
  Blend One OneMinusSrcAlpha
  ColorMask [_ColorMask]
  //////////////////////////////////
  //                              //
  //      Compiled programs       //
  //                              //
  //////////////////////////////////
//////////////////////////////////////////////////////
Keywords: <none>
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (264 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 16
  Matrix4x4 glstate_matrix_projection at 80
  Matrix4x4 unity_MatrixVP at 144
  Vector4 _ScreenParams at 0
  Vector4 _Color at 208
  Vector4 _ClipRect at 224
  Vector4 _MainTex_ST at 240
  Float _UIMaskSoftnessX at 256
  Float _UIMaskSoftnessY at 260
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;
struct VGlobals_Type
{
    float4 _ScreenParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4glstate_matrix_projection[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _Color;
    float4 _ClipRect;
    float4 _MainTex_ST;
    float _UIMaskSoftnessX;
    float _UIMaskSoftnessY;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position, invariant ]];
    float4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    output.COLOR0 = input.COLOR0 * VGlobals._Color;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD1 = input.POSITION0;
    u_xlat0.xy = VGlobals._ScreenParams.yy * VGlobals.hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4glstate_matrix_projection[0].xy, VGlobals._ScreenParams.xx, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = fma(float2(VGlobals._UIMaskSoftnessX, VGlobals._UIMaskSoftnessY), float2(0.25, 0.25), abs(u_xlat0.xy));
    output.TEXCOORD2.zw = float2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(VGlobals._ClipRect, float4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, float4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = fma(input.POSITION0.xy, float2(2.0, 2.0), (-u_xlat0.xy));
    output.TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0

Constant Buffer "FGlobals" (16 bytes) on slot 0 {
  Vector4 _TextureSampleAdd at 0
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;
constant uint32_t rp_output_remap_mask [[ function_constant(1) ]];
constant const uint rp_output_remap_0 = (rp_output_remap_mask >> 0) & 0xF;
struct FGlobals_Type
{
    float4 _TextureSampleAdd;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(rp_output_remap_0) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0.x = input.COLOR0.w * 255.0;
    u_xlat0.x = rint(u_xlat0.x);
    u_xlat0.w = u_xlat0.x * 0.00392156886;
    u_xlat1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat1 = u_xlat1 + FGlobals._TextureSampleAdd;
    u_xlat0.xyz = input.COLOR0.xyz;
    u_xlat0 = u_xlat0 * u_xlat1;
    output.SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
    output.SV_Target0.w = u_xlat0.w;
    return output;
}


//////////////////////////////////////////////////////
Keywords: UNITY_UI_ALPHACLIP
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (264 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 16
  Matrix4x4 glstate_matrix_projection at 80
  Matrix4x4 unity_MatrixVP at 144
  Vector4 _ScreenParams at 0
  Vector4 _Color at 208
  Vector4 _ClipRect at 224
  Vector4 _MainTex_ST at 240
  Float _UIMaskSoftnessX at 256
  Float _UIMaskSoftnessY at 260
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;
struct VGlobals_Type
{
    float4 _ScreenParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4glstate_matrix_projection[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _Color;
    float4 _ClipRect;
    float4 _MainTex_ST;
    float _UIMaskSoftnessX;
    float _UIMaskSoftnessY;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position, invariant ]];
    float4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    output.COLOR0 = input.COLOR0 * VGlobals._Color;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD1 = input.POSITION0;
    u_xlat0.xy = VGlobals._ScreenParams.yy * VGlobals.hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4glstate_matrix_projection[0].xy, VGlobals._ScreenParams.xx, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = fma(float2(VGlobals._UIMaskSoftnessX, VGlobals._UIMaskSoftnessY), float2(0.25, 0.25), abs(u_xlat0.xy));
    output.TEXCOORD2.zw = float2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(VGlobals._ClipRect, float4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, float4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = fma(input.POSITION0.xy, float2(2.0, 2.0), (-u_xlat0.xy));
    output.TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0

Constant Buffer "FGlobals" (16 bytes) on slot 0 {
  Vector4 _TextureSampleAdd at 0
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;
constant uint32_t rp_output_remap_mask [[ function_constant(1) ]];
constant const uint rp_output_remap_0 = (rp_output_remap_mask >> 0) & 0xF;
struct FGlobals_Type
{
    float4 _TextureSampleAdd;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(rp_output_remap_0) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    float u_xlat2;
    bool u_xlatb2;
    u_xlat0.x = input.COLOR0.w * 255.0;
    u_xlat0.x = rint(u_xlat0.x);
    u_xlat0.w = u_xlat0.x * 0.00392156886;
    u_xlat1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat1 = u_xlat1 + FGlobals._TextureSampleAdd;
    u_xlat2 = fma(u_xlat0.w, u_xlat1.w, -0.00100000005);
    u_xlatb2 = u_xlat2<0.0;
    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard_fragment();}
    u_xlat0.xyz = input.COLOR0.xyz;
    u_xlat0 = u_xlat0 * u_xlat1;
    output.SV_Target0.xyz = u_xlat0.www * u_xlat0.xyz;
    output.SV_Target0.w = u_xlat0.w;
    return output;
}


//////////////////////////////////////////////////////
Keywords: UNITY_UI_CLIP_RECT
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (264 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 16
  Matrix4x4 glstate_matrix_projection at 80
  Matrix4x4 unity_MatrixVP at 144
  Vector4 _ScreenParams at 0
  Vector4 _Color at 208
  Vector4 _ClipRect at 224
  Vector4 _MainTex_ST at 240
  Float _UIMaskSoftnessX at 256
  Float _UIMaskSoftnessY at 260
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;
struct VGlobals_Type
{
    float4 _ScreenParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4glstate_matrix_projection[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _Color;
    float4 _ClipRect;
    float4 _MainTex_ST;
    float _UIMaskSoftnessX;
    float _UIMaskSoftnessY;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position, invariant ]];
    float4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    output.COLOR0 = input.COLOR0 * VGlobals._Color;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD1 = input.POSITION0;
    u_xlat0.xy = VGlobals._ScreenParams.yy * VGlobals.hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4glstate_matrix_projection[0].xy, VGlobals._ScreenParams.xx, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = fma(float2(VGlobals._UIMaskSoftnessX, VGlobals._UIMaskSoftnessY), float2(0.25, 0.25), abs(u_xlat0.xy));
    output.TEXCOORD2.zw = float2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(VGlobals._ClipRect, float4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, float4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = fma(input.POSITION0.xy, float2(2.0, 2.0), (-u_xlat0.xy));
    output.TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0

Constant Buffer "FGlobals" (32 bytes) on slot 0 {
  Vector4 _TextureSampleAdd at 0
  Vector4 _ClipRect at 16
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;
constant uint32_t rp_output_remap_mask [[ function_constant(1) ]];
constant const uint rp_output_remap_0 = (rp_output_remap_mask >> 0) & 0xF;
struct FGlobals_Type
{
    float4 _TextureSampleAdd;
    float4 _ClipRect;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(rp_output_remap_0) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float2 u_xlat0;
    float4 u_xlat1;
    float4 u_xlat2;
    float u_xlat3;
    u_xlat0.xy = (-FGlobals._ClipRect.xy) + FGlobals._ClipRect.zw;
    u_xlat0.xy = u_xlat0.xy + -abs(input.TEXCOORD2.xy);
    u_xlat0.xy = u_xlat0.xy * input.TEXCOORD2.zw;
    u_xlat0.xy = clamp(u_xlat0.xy, 0.0f, 1.0f);
    u_xlat0.x = u_xlat0.y * u_xlat0.x;
    u_xlat3 = input.COLOR0.w * 255.0;
    u_xlat3 = rint(u_xlat3);
    u_xlat1.w = u_xlat3 * 0.00392156886;
    u_xlat2 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat2 = u_xlat2 + FGlobals._TextureSampleAdd;
    u_xlat1.xyz = input.COLOR0.xyz;
    u_xlat1 = u_xlat1 * u_xlat2;
    u_xlat0.x = u_xlat0.x * u_xlat1.w;
    output.SV_Target0.xyz = u_xlat0.xxx * u_xlat1.xyz;
    output.SV_Target0.w = u_xlat0.x;
    return output;
}


//////////////////////////////////////////////////////
Keywords: UNITY_UI_ALPHACLIP UNITY_UI_CLIP_RECT
-- Hardware tier variant: Tier 1
-- Vertex shader for "metal":
Uses vertex data channel "Vertex"
Uses vertex data channel "Color"
Uses vertex data channel "TexCoord0"

Constant Buffer "VGlobals" (264 bytes) on slot 0 {
  Matrix4x4 unity_ObjectToWorld at 16
  Matrix4x4 glstate_matrix_projection at 80
  Matrix4x4 unity_MatrixVP at 144
  Vector4 _ScreenParams at 0
  Vector4 _Color at 208
  Vector4 _ClipRect at 224
  Vector4 _MainTex_ST at 240
  Float _UIMaskSoftnessX at 256
  Float _UIMaskSoftnessY at 260
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;
struct VGlobals_Type
{
    float4 _ScreenParams;
    float4 hlslcc_mtx4x4unity_ObjectToWorld[4];
    float4 hlslcc_mtx4x4glstate_matrix_projection[4];
    float4 hlslcc_mtx4x4unity_MatrixVP[4];
    float4 _Color;
    float4 _ClipRect;
    float4 _MainTex_ST;
    float _UIMaskSoftnessX;
    float _UIMaskSoftnessY;
};

struct Mtl_VertexIn
{
    float4 POSITION0 [[ attribute(0) ]] ;
    float4 COLOR0 [[ attribute(1) ]] ;
    float2 TEXCOORD0 [[ attribute(2) ]] ;
};

struct Mtl_VertexOut
{
    float4 mtl_Position [[ position, invariant ]];
    float4 COLOR0 [[ user(COLOR0) ]];
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]];
    float4 TEXCOORD1 [[ user(TEXCOORD1) ]];
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]];
};

vertex Mtl_VertexOut xlatMtlMain(
    constant VGlobals_Type& VGlobals [[ buffer(0) ]],
    Mtl_VertexIn input [[ stage_in ]])
{
    Mtl_VertexOut output;
    float4 u_xlat0;
    float4 u_xlat1;
    u_xlat0 = input.POSITION0.yyyy * VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[0], input.POSITION0.xxxx, u_xlat0);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[2], input.POSITION0.zzzz, u_xlat0);
    u_xlat0 = u_xlat0 + VGlobals.hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * VGlobals.hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[0], u_xlat0.xxxx, u_xlat1);
    u_xlat1 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[2], u_xlat0.zzzz, u_xlat1);
    u_xlat0 = fma(VGlobals.hlslcc_mtx4x4unity_MatrixVP[3], u_xlat0.wwww, u_xlat1);
    output.mtl_Position = u_xlat0;
    output.COLOR0 = input.COLOR0 * VGlobals._Color;
    output.TEXCOORD0.xy = fma(input.TEXCOORD0.xy, VGlobals._MainTex_ST.xy, VGlobals._MainTex_ST.zw);
    output.TEXCOORD1 = input.POSITION0;
    u_xlat0.xy = VGlobals._ScreenParams.yy * VGlobals.hlslcc_mtx4x4glstate_matrix_projection[1].xy;
    u_xlat0.xy = fma(VGlobals.hlslcc_mtx4x4glstate_matrix_projection[0].xy, VGlobals._ScreenParams.xx, u_xlat0.xy);
    u_xlat0.xy = u_xlat0.ww / abs(u_xlat0.xy);
    u_xlat0.xy = fma(float2(VGlobals._UIMaskSoftnessX, VGlobals._UIMaskSoftnessY), float2(0.25, 0.25), abs(u_xlat0.xy));
    output.TEXCOORD2.zw = float2(0.25, 0.25) / u_xlat0.xy;
    u_xlat0 = max(VGlobals._ClipRect, float4(-2e+10, -2e+10, -2e+10, -2e+10));
    u_xlat0 = min(u_xlat0, float4(2e+10, 2e+10, 2e+10, 2e+10));
    u_xlat0.xy = fma(input.POSITION0.xy, float2(2.0, 2.0), (-u_xlat0.xy));
    output.TEXCOORD2.xy = (-u_xlat0.zw) + u_xlat0.xy;
    return output;
}


-- Hardware tier variant: Tier 1
-- Fragment shader for "metal":
Set 2D Texture "_MainTex" to slot 0

Constant Buffer "FGlobals" (32 bytes) on slot 0 {
  Vector4 _TextureSampleAdd at 0
  Vector4 _ClipRect at 16
}

Shader Disassembly:
#include <metal_stdlib>
#include <metal_texture>
using namespace metal;
constant uint32_t rp_output_remap_mask [[ function_constant(1) ]];
constant const uint rp_output_remap_0 = (rp_output_remap_mask >> 0) & 0xF;
struct FGlobals_Type
{
    float4 _TextureSampleAdd;
    float4 _ClipRect;
};

struct Mtl_FragmentIn
{
    float4 COLOR0 [[ user(COLOR0) ]] ;
    float2 TEXCOORD0 [[ user(TEXCOORD0) ]] ;
    float4 TEXCOORD2 [[ user(TEXCOORD2) ]] ;
};

struct Mtl_FragmentOut
{
    float4 SV_Target0 [[ color(rp_output_remap_0) ]];
};

fragment Mtl_FragmentOut xlatMtlMain(
    constant FGlobals_Type& FGlobals [[ buffer(0) ]],
    sampler sampler_MainTex [[ sampler (0) ]],
    texture2d<float, access::sample > _MainTex [[ texture(0) ]] ,
    Mtl_FragmentIn input [[ stage_in ]])
{
    Mtl_FragmentOut output;
    float4 u_xlat0;
    bool u_xlatb0;
    float4 u_xlat1;
    float u_xlat3;
    float u_xlat6;
    u_xlat0.x = input.COLOR0.w * 255.0;
    u_xlat0.x = rint(u_xlat0.x);
    u_xlat0.w = u_xlat0.x * 0.00392156886;
    u_xlat1 = _MainTex.sample(sampler_MainTex, input.TEXCOORD0.xy);
    u_xlat1 = u_xlat1 + FGlobals._TextureSampleAdd;
    u_xlat0.xyz = input.COLOR0.xyz;
    u_xlat0 = u_xlat0 * u_xlat1;
    u_xlat1.xy = (-FGlobals._ClipRect.xy) + FGlobals._ClipRect.zw;
    u_xlat1.xy = u_xlat1.xy + -abs(input.TEXCOORD2.xy);
    u_xlat1.xy = u_xlat1.xy * input.TEXCOORD2.zw;
    u_xlat1.xy = clamp(u_xlat1.xy, 0.0f, 1.0f);
    u_xlat1.x = u_xlat1.y * u_xlat1.x;
    u_xlat3 = fma(u_xlat0.w, u_xlat1.x, -0.00100000005);
    u_xlat6 = u_xlat0.w * u_xlat1.x;
    output.SV_Target0.xyz = float3(u_xlat6) * u_xlat0.xyz;
    output.SV_Target0.w = u_xlat6;
    u_xlatb0 = u_xlat3<0.0;
    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard_fragment();}
    return output;
}


 }
}
}