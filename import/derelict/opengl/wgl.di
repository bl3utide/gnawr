// D import file generated from 'derelict\opengl\wgl.d'
module derelict.opengl.wgl;
private 
{
	import derelict.util.wintypes;
	import derelict.util.compat;
}
version (Windows)
{
	extern (Windows) 
	{
		alias BOOL function(void*, void*) da_wglCopyContext;
		alias void* function(void*) da_wglCreateContext;
		alias void* function(void*, int) da_wglCreateLayerContext;
		alias BOOL function(void*) da_wglDeleteContext;
		alias BOOL function(void*, int, int, UINT, LAYERPLANEDESCRIPTOR*) da_wglDescribeLayerPlane;
		alias void* function() da_wglGetCurrentContext;
		alias void* function() da_wglGetCurrentDC;
		alias int function(void*, int, int, int, COLORREF*) da_wglGetLayerPaletteEntries;
		alias FARPROC function(LPCSTR) da_wglGetProcAddress;
		alias BOOL function(void*, void*) da_wglMakeCurrent;
		alias BOOL function(void*, int, BOOL) da_wglRealizeLayerPalette;
		alias int function(void*, int, int, int, COLORREF*) da_wglSetLayerPaletteEntries;
		alias BOOL function(void*, void*) da_wglShareLists;
		alias BOOL function(void*, UINT) da_wglSwapLayerBuffers;
		alias BOOL function(void*, DWORD, DWORD, DWORD) da_wglUseFontBitmapsA;
		alias BOOL function(void*, DWORD, DWORD, DWORD, FLOAT, FLOAT, int, GLYPHMETRICSFLOAT*) da_wglUseFontOutlinesA;
		alias BOOL function(void*, DWORD, DWORD, DWORD) da_wglUseFontBitmapsW;
		alias BOOL function(void*, DWORD, DWORD, DWORD, FLOAT, FLOAT, int, GLYPHMETRICSFLOAT*) da_wglUseFontOutlinesW;
	}
	mixin(gsharedString!() ~ "\x0a    da_wglCopyContext wglCopyContext;\x0a    da_wglCreateContext wglCreateContext;\x0a    da_wglCreateLayerContext wglCreateLayerContext;\x0a    da_wglDeleteContext wglDeleteContext;\x0a    da_wglDescribeLayerPlane wglDescribeLayerPlane;\x0a    da_wglGetCurrentContext wglGetCurrentContext;\x0a    da_wglGetCurrentDC wglGetCurrentDC;\x0a    da_wglGetLayerPaletteEntries wglGetLayerPaletteEntries;\x0a    da_wglGetProcAddress wglGetProcAddress;\x0a    da_wglMakeCurrent wglMakeCurrent;\x0a    da_wglRealizeLayerPalette wglRealizeLayerPalette;\x0a    da_wglSetLayerPaletteEntries wglSetLayerPaletteEntries;\x0a    da_wglShareLists wglShareLists;\x0a    da_wglSwapLayerBuffers wglSwapLayerBuffers;\x0a    da_wglUseFontBitmapsA wglUseFontBitmapsA;\x0a    da_wglUseFontOutlinesA wglUseFontOutlinesA;\x0a    da_wglUseFontBitmapsW wglUseFontBitmapsW;\x0a    da_wglUseFontOutlinesW wglUseFontOutlinesW;\x0a\x0a    alias wglUseFontBitmapsA    wglUseFontBitmaps;\x0a    alias wglUseFontOutlinesA   wglUseFontOutlines;\x0a    ");
	package 
	{
		void loadPlatformGL(void delegate(void**, string, bool doThrow) bindFunc)
		{
			bindFunc(cast(void**)&wglCopyContext, "wglCopyContext", true);
			bindFunc(cast(void**)&wglCreateContext, "wglCreateContext", true);
			bindFunc(cast(void**)&wglCreateLayerContext, "wglCreateLayerContext", true);
			bindFunc(cast(void**)&wglDeleteContext, "wglDeleteContext", true);
			bindFunc(cast(void**)&wglDescribeLayerPlane, "wglDescribeLayerPlane", true);
			bindFunc(cast(void**)&wglGetCurrentContext, "wglGetCurrentContext", true);
			bindFunc(cast(void**)&wglGetCurrentDC, "wglGetCurrentDC", true);
			bindFunc(cast(void**)&wglGetLayerPaletteEntries, "wglGetLayerPaletteEntries", true);
			bindFunc(cast(void**)&wglGetProcAddress, "wglGetProcAddress", true);
			bindFunc(cast(void**)&wglMakeCurrent, "wglMakeCurrent", true);
			bindFunc(cast(void**)&wglRealizeLayerPalette, "wglRealizeLayerPalette", true);
			bindFunc(cast(void**)&wglSetLayerPaletteEntries, "wglSetLayerPaletteEntries", true);
			bindFunc(cast(void**)&wglShareLists, "wglShareLists", true);
			bindFunc(cast(void**)&wglSwapLayerBuffers, "wglSwapLayerBuffers", true);
			bindFunc(cast(void**)&wglUseFontBitmapsA, "wglUseFontBitmapsA", true);
			bindFunc(cast(void**)&wglUseFontOutlinesA, "wglUseFontOutlinesA", true);
			bindFunc(cast(void**)&wglUseFontBitmapsW, "wglUseFontBitmapsW", true);
			bindFunc(cast(void**)&wglUseFontOutlinesW, "wglUseFontOutlinesW", true);
		}

		void* loadGLSymbol(string symName)
		{
			return cast(void*)wglGetProcAddress(toCString(symName));
		}

	}
}
