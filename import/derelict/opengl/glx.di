// D import file generated from 'derelict\opengl\glx.d'
module derelict.opengl.glx;
version (freebsd)
{
	version = GLX;
}
else
{
	version (FreeBSD)
	{
		version = GLX;
	}
	else
	{
		version (linux)
		{
			version = GLX;
		}
	}
}
version (GLX)
{
	private 
	{
		import derelict.opengl.gltypes;
		import derelict.util.compat;
		import derelict.util.loader;
		import derelict.util.xtypes;
	}
	struct __GLXcontextRec
	{
	}
	struct __GLXFBConfigRec
	{
	}
	alias uint GLXContentID;
	alias uint GLXPixmap;
	alias uint GLXDrawable;
	alias uint GLXPbuffer;
	alias uint GLXWindow;
	alias uint GLXFBConfigID;
	alias __GLXcontextRec* GLXContext;
	alias __GLXFBConfigRec* GLXFBConfig;
	struct GLXPbufferClobberEvent
	{
		int event_type;
		int draw_type;
		uint serial;
		Bool send_event;
		Display* display;
		GLXDrawable drawable;
		uint buffer_mask;
		uint aux_buffer;
		int x;
		int y;
		int width;
		int height;
		int count;
	}
	union GLXEvent
	{
		GLXPbufferClobberEvent glxpbufferclobber;
		int[24] pad;
	}
	extern (C) 
	{
		alias XVisualInfo* function(Display*, int, int*) da_glXChooseVisual;
		alias void function(Display*, GLXContext, GLXContext, uint) da_glXCopyContext;
		alias GLXContext function(Display*, XVisualInfo*, GLXContext, Bool) da_glXCreateContext;
		alias GLXPixmap function(Display*, XVisualInfo*, Pixmap) da_glXCreateGLXPixmap;
		alias void function(Display*, GLXContext) da_glXDestroyContext;
		alias void function(Display*, GLXPixmap) da_glXDestroyGLXPixmap;
		alias int function(Display*, XVisualInfo*, int, int*) da_glXGetConfig;
		alias GLXContext function() da_glXGetCurrentContext;
		alias GLXDrawable function() da_glXGetCurrentDrawable;
		alias Bool function(Display*, GLXContext) da_glXIsDirect;
		alias Bool function(Display*, GLXDrawable, GLXContext) da_glXMakeCurrent;
		alias Bool function(Display*, int*, int*) da_glXQueryExtension;
		alias Bool function(Display*, int*, int*) da_glXQueryVersion;
		alias void function(Display*, GLXDrawable) da_glXSwapBuffers;
		alias void function(Font, int, int, int) da_glXUseXFont;
		alias void function() da_glXWaitGL;
		alias void function() da_glXWaitX;
		alias char* function(Display*, int) da_glXGetClientString;
		alias char* function(Display*, int, int) da_glXQueryServerString;
		alias char* function(Display*, int) da_glXQueryExtensionsString;
		alias GLXFBConfig* function(Display*, int, int*) da_glXGetFBConfigs;
		alias GLXFBConfig* function(Display*, int, int*, int*) da_glXChooseFBConfig;
		alias int function(Display*, GLXFBConfig, int, int*) da_glXGetFBConfigAttrib;
		alias XVisualInfo* function(Display*, GLXFBConfig) da_glXGetVisualFromFBConfig;
		alias GLXWindow function(Display*, GLXFBConfig, Window, int*) da_glXCreateWindow;
		alias void function(Display*, GLXWindow) da_glXDestroyWindow;
		alias GLXPixmap function(Display*, GLXFBConfig, Pixmap, int*) da_glXCreatePixmap;
		alias void function(Display*, GLXPixmap) da_glXDestroyPixmap;
		alias GLXPbuffer function(Display*, GLXFBConfig, int*) da_glXCreatePbuffer;
		alias void function(Display*, GLXPbuffer) da_glXDestroyPbuffer;
		alias void function(Display*, GLXDrawable, int, uint*) da_glXQueryDrawable;
		alias GLXContext function(Display*, GLXFBConfig, int, GLXContext, Bool) da_glXCreateNewContext;
		alias Bool function(Display*, GLXDrawable, GLXDrawable, GLXContext) da_glXMakeContextCurrent;
		alias GLXDrawable function() da_glXGetCurrentReadDrawable;
		alias Display* function() da_glXGetCurrentDisplay;
		alias int function(Display*, GLXContext, int, int*) da_glXQueryContext;
		alias void function(Display*, GLXDrawable, uint) da_glXSelectEvent;
		alias void function(Display*, GLXDrawable, uint*) da_glXGetSelectedEvent;
		alias void* function(CCPTR) da_glXGetProcAddress;
	}
	mixin(gsharedString!() ~ "\x0ada_glXChooseVisual glXChooseVisual;\x0ada_glXCopyContext glXCopyContext;\x0ada_glXCreateContext glXCreateContext;\x0ada_glXCreateGLXPixmap glXCreateGLXPixmap;\x0ada_glXDestroyContext glXDestroyContext;\x0ada_glXDestroyGLXPixmap glXDestroyGLXPixmap;\x0ada_glXGetConfig glXGetConfig;\x0ada_glXGetCurrentContext glXGetCurrentContext;\x0ada_glXGetCurrentDrawable glXGetCurrentDrawable;\x0ada_glXIsDirect glXIsDirect;\x0ada_glXMakeCurrent glXMakeCurrent;\x0ada_glXQueryExtension glXQueryExtension;\x0ada_glXQueryVersion glXQueryVersion;\x0ada_glXSwapBuffers glXSwapBuffers;\x0ada_glXUseXFont glXUseXFont;\x0ada_glXWaitGL glXWaitGL;\x0ada_glXWaitX glXWaitX;\x0ada_glXGetClientString glXGetClientString;\x0ada_glXQueryServerString glXQueryServerString;\x0ada_glXQueryExtensionsString glXQueryExtensionsString;\x0a\x0a/* GLX 1.3 */\x0a\x0ada_glXGetFBConfigs glXGetFBConfigs;\x0ada_glXChooseFBConfig glXChooseFBConfig;\x0ada_glXGetFBConfigAttrib glXGetFBConfigAttrib;\x0ada_glXGetVisualFromFBConfig glXGetVisualFromFBConfig;\x0ada_glXCreateWindow glXCreateWindow;\x0ada_glXDestroyWindow glXDestroyWindow;\x0ada_glXCreatePixmap glXCreatePixmap;\x0ada_glXDestroyPixmap glXDestroyPixmap;\x0ada_glXCreatePbuffer glXCreatePbuffer;\x0ada_glXDestroyPbuffer glXDestroyPbuffer;\x0ada_glXQueryDrawable glXQueryDrawable;\x0ada_glXCreateNewContext glXCreateNewContext;\x0ada_glXMakeContextCurrent glXMakeContextCurrent;\x0ada_glXGetCurrentReadDrawable glXGetCurrentReadDrawable;\x0ada_glXGetCurrentDisplay glXGetCurrentDisplay;\x0ada_glXQueryContext glXQueryContext;\x0ada_glXSelectEvent glXSelectEvent;\x0ada_glXGetSelectedEvent glXGetSelectedEvent;\x0a\x0a/* GLX 1.4+ */\x0ada_glXGetProcAddress glXGetProcAddress;\x0a\x0a");
	package 
	{
		void loadPlatformGL(void delegate(void**, string, bool doThrow) bindFunc)
		{
			bindFunc(cast(void**)&glXChooseVisual, "glXChooseVisual", true);
			bindFunc(cast(void**)&glXCopyContext, "glXCopyContext", true);
			bindFunc(cast(void**)&glXCreateContext, "glXCreateContext", true);
			bindFunc(cast(void**)&glXCreateGLXPixmap, "glXCreateGLXPixmap", true);
			bindFunc(cast(void**)&glXDestroyContext, "glXDestroyContext", true);
			bindFunc(cast(void**)&glXDestroyGLXPixmap, "glXDestroyGLXPixmap", true);
			bindFunc(cast(void**)&glXGetConfig, "glXGetConfig", true);
			bindFunc(cast(void**)&glXGetCurrentContext, "glXGetCurrentContext", true);
			bindFunc(cast(void**)&glXGetCurrentDrawable, "glXGetCurrentDrawable", true);
			bindFunc(cast(void**)&glXIsDirect, "glXIsDirect", true);
			bindFunc(cast(void**)&glXMakeCurrent, "glXMakeCurrent", true);
			bindFunc(cast(void**)&glXQueryExtension, "glXQueryExtension", true);
			bindFunc(cast(void**)&glXQueryVersion, "glXQueryVersion", true);
			bindFunc(cast(void**)&glXSwapBuffers, "glXSwapBuffers", true);
			bindFunc(cast(void**)&glXUseXFont, "glXUseXFont", true);
			bindFunc(cast(void**)&glXWaitGL, "glXWaitGL", true);
			bindFunc(cast(void**)&glXWaitX, "glXWaitX", true);
			bindFunc(cast(void**)&glXGetClientString, "glXGetClientString", true);
			bindFunc(cast(void**)&glXQueryServerString, "glXQueryServerString", true);
			bindFunc(cast(void**)&glXQueryExtensionsString, "glXQueryExtensionsString", true);
			bindFunc(cast(void**)&glXGetFBConfigs, "glXGetFBConfigs", true);
			bindFunc(cast(void**)&glXChooseFBConfig, "glXChooseFBConfig", true);
			bindFunc(cast(void**)&glXGetFBConfigAttrib, "glXGetFBConfigAttrib", true);
			bindFunc(cast(void**)&glXGetVisualFromFBConfig, "glXGetVisualFromFBConfig", true);
			bindFunc(cast(void**)&glXCreateWindow, "glXCreateWindow", true);
			bindFunc(cast(void**)&glXDestroyWindow, "glXDestroyWindow", true);
			bindFunc(cast(void**)&glXCreatePixmap, "glXCreatePixmap", true);
			bindFunc(cast(void**)&glXDestroyPixmap, "glXDestroyPixmap", true);
			bindFunc(cast(void**)&glXCreatePbuffer, "glXCreatePbuffer", true);
			bindFunc(cast(void**)&glXDestroyPbuffer, "glXDestroyPbuffer", true);
			bindFunc(cast(void**)&glXQueryDrawable, "glXQueryDrawable", true);
			bindFunc(cast(void**)&glXCreateNewContext, "glXCreateNewContext", true);
			bindFunc(cast(void**)&glXMakeContextCurrent, "glXMakeContextCurrent", true);
			bindFunc(cast(void**)&glXGetCurrentReadDrawable, "glXGetCurrentReadDrawable", true);
			bindFunc(cast(void**)&glXGetCurrentDisplay, "glXGetCurrentDisplay", true);
			bindFunc(cast(void**)&glXQueryContext, "glXQueryContext", true);
			bindFunc(cast(void**)&glXSelectEvent, "glXSelectEvent", true);
			bindFunc(cast(void**)&glXGetSelectedEvent, "glXGetSelectedEvent", true);
			bindFunc(cast(void**)&glXGetProcAddress, "glXGetProcAddressARB", true);
		}

		void* loadGLSymbol(string symName)
		{
			return glXGetProcAddress(toCString(symName));
		}

	}
}
