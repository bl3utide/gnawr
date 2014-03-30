// D import file generated from 'derelict\util\loader.d'
module derelict.util.loader;
private 
{
	import derelict.util.sharedlib;
	import derelict.util.compat;
}
class SharedLibLoader
{
	public 
	{
		this(string winLibs, string nixLibs, string macLibs)
		{
			version (Windows)
			{
				_libNames = winLibs;
			}
			else
			{
				version (OSX)
				{
					_libNames = macLibs;
				}
				else
				{
					version (darwin)
					{
						_libNames = macLibs;
					}
					else
					{
						_libNames = nixLibs;
					}

				}

			}

			_lib = new SharedLib;
		}

		static void disableAutoUnload()
		{
			_manualUnload = true;
		}


		static bool isAutoUnloadEnabled()
		{
			return _manualUnload == false;
		}


		void load()
		{
			load(_libNames);
		}

		void load(string libNameString)
		{
			assert(libNameString !is null);
			string[] libNames = libNameString.splitStr(",");
			foreach (ref string l; libNames)
			{
				l = l.stripWhiteSpace();
			}
			load(libNames);
		}

		void load(string[] libNames)
		{
			_lib.load(libNames);
			loadSymbols();
		}

		void unload()
		{
			_lib.unload();
		}

		bool isLoaded()
		{
			return _lib.isLoaded;
		}

		protected 
		{
			abstract void loadSymbols();


			void* loadSymbol(string name)
			{
				return _lib.loadSymbol(name);
			}

			SharedLib lib()
			{
				return _lib;
			}

			void bindFunc(void** ptr, string funcName, bool doThrow = true)
			{
				void* func = lib.loadSymbol(funcName, doThrow);
				*ptr = func;
			}

			private 
			{
				static bool _manualUnload;

				string _libNames;
				SharedLib _lib;
			}
		}
	}
}
package struct Binder(T)
{
	void opCall(in char[] n, SharedLib lib)
	{
		*fptr = lib.loadSymbol(n);
	}

	private void** fptr;

}

Binder!T bindFunc(T)(inout T a)
{
	Binder!T res;
	res.fptr = cast(void**)&a;
	return res;
}
