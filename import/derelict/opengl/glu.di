// D import file generated from 'derelict\opengl\glu.d'
module derelict.opengl.glu;
public 
{
	import derelict.opengl.glutypes;
	import derelict.opengl.glufuncs;
}
private 
{
	import derelict.util.loader;
	import derelict.util.exception;
}
class DerelictGLULoader : SharedLibLoader
{
	private 
	{
		this()
		{
			super("glu32.dll", "libGLU.so,libGLU.so.1", "../Frameworks/OpenGL.framework/OpenGL, /Library/Frameworks/OpenGL.framework/OpenGL, /System/Library/Frameworks/OpenGL.framework/OpenGL");
		}

		protected override void loadSymbols()
		{
			bindFunc(cast(void**)&gluBeginCurve, "gluBeginCurve");
			bindFunc(cast(void**)&gluBeginPolygon, "gluBeginPolygon");
			bindFunc(cast(void**)&gluBeginSurface, "gluBeginSurface");
			bindFunc(cast(void**)&gluBeginTrim, "gluBeginTrim");
			bindFunc(cast(void**)&gluBuild1DMipmaps, "gluBuild1DMipmaps");
			bindFunc(cast(void**)&gluBuild2DMipmaps, "gluBuild2DMipmaps");
			bindFunc(cast(void**)&gluCylinder, "gluCylinder");
			bindFunc(cast(void**)&gluDeleteNurbsRenderer, "gluDeleteNurbsRenderer");
			bindFunc(cast(void**)&gluDeleteQuadric, "gluDeleteQuadric");
			bindFunc(cast(void**)&gluDeleteTess, "gluDeleteTess");
			bindFunc(cast(void**)&gluDisk, "gluDisk");
			bindFunc(cast(void**)&gluEndCurve, "gluEndCurve");
			bindFunc(cast(void**)&gluEndPolygon, "gluEndPolygon");
			bindFunc(cast(void**)&gluEndSurface, "gluEndSurface");
			bindFunc(cast(void**)&gluEndTrim, "gluEndTrim");
			bindFunc(cast(void**)&gluErrorString, "gluErrorString");
			bindFunc(cast(void**)&gluGetNurbsProperty, "gluGetNurbsProperty");
			bindFunc(cast(void**)&gluGetString, "gluGetString");
			bindFunc(cast(void**)&gluGetTessProperty, "gluGetTessProperty");
			bindFunc(cast(void**)&gluLoadSamplingMatrices, "gluLoadSamplingMatrices");
			bindFunc(cast(void**)&gluLookAt, "gluLookAt");
			bindFunc(cast(void**)&gluNewNurbsRenderer, "gluNewNurbsRenderer");
			bindFunc(cast(void**)&gluNewQuadric, "gluNewQuadric");
			bindFunc(cast(void**)&gluNewTess, "gluNewTess");
			bindFunc(cast(void**)&gluNextContour, "gluNextContour");
			bindFunc(cast(void**)&gluNurbsCallback, "gluNurbsCallback");
			bindFunc(cast(void**)&gluNurbsCurve, "gluNurbsCurve");
			bindFunc(cast(void**)&gluNurbsProperty, "gluNurbsProperty");
			bindFunc(cast(void**)&gluNurbsSurface, "gluNurbsSurface");
			bindFunc(cast(void**)&gluOrtho2D, "gluOrtho2D");
			bindFunc(cast(void**)&gluPartialDisk, "gluPartialDisk");
			bindFunc(cast(void**)&gluPerspective, "gluPerspective");
			bindFunc(cast(void**)&gluPickMatrix, "gluPickMatrix");
			bindFunc(cast(void**)&gluProject, "gluProject");
			bindFunc(cast(void**)&gluPwlCurve, "gluPwlCurve");
			bindFunc(cast(void**)&gluQuadricCallback, "gluQuadricCallback");
			bindFunc(cast(void**)&gluQuadricDrawStyle, "gluQuadricDrawStyle");
			bindFunc(cast(void**)&gluQuadricNormals, "gluQuadricNormals");
			bindFunc(cast(void**)&gluQuadricOrientation, "gluQuadricOrientation");
			bindFunc(cast(void**)&gluQuadricTexture, "gluQuadricTexture");
			bindFunc(cast(void**)&gluScaleImage, "gluScaleImage");
			bindFunc(cast(void**)&gluSphere, "gluSphere");
			bindFunc(cast(void**)&gluTessBeginContour, "gluTessBeginContour");
			bindFunc(cast(void**)&gluTessBeginPolygon, "gluTessBeginPolygon");
			bindFunc(cast(void**)&gluTessCallback, "gluTessCallback");
			bindFunc(cast(void**)&gluTessEndContour, "gluTessEndContour");
			bindFunc(cast(void**)&gluTessEndPolygon, "gluTessEndPolygon");
			bindFunc(cast(void**)&gluTessNormal, "gluTessNormal");
			bindFunc(cast(void**)&gluTessProperty, "gluTessProperty");
			bindFunc(cast(void**)&gluTessVertex, "gluTessVertex");
			bindFunc(cast(void**)&gluUnProject, "gluUnProject");
		}



	}
}
DerelictGLULoader DerelictGLU;
static this();
