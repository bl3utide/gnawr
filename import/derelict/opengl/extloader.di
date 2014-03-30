// D import file generated from 'derelict\opengl\extloader.d'
module derelict.opengl.extloader;
private 
{
	import derelict.opengl.extfuncs;
	import derelict.opengl.gltypes;
	import derelict.opengl.glfuncs;
	import derelict.util.compat;
	import derelict.util.exception;
	version (darwin)
	{
		version = CGL;
	}
	else
	{
		version (OSX)
		{
			version = CGL;
		}
		else
		{
			version (linux)
			{
				version = GLX;
			}
			else
			{
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
				}
			}
		}
	}
	version (Windows)
	{
		import derelict.opengl.wgl;
		import derelict.util.wintypes;
	}
	version (GLX)
	{
		import derelict.opengl.glx;
	}
	version (CGL)
	{
		import derelict.opengl.cgl;
		import derelict.opengl.gl;
	}
}
version = DerelictGL_ALL;
version (DerelictGL_ALL)
{
	version = DerelictGL_ARB;
	version = DerelictGL_EXT;
	version = DerelictGL_NV;
	version = DerelictGL_ATI;
	version = DerelictGL_AMD;
	version = DerelictGL_SGI;
	version = DerelictGL_SGIS;
	version = DerelictGL_SGIX;
	version = DerelictGL_HP;
	version = DerelictGL_PGI;
	version = DerelictGL_IBM;
	version = DerelictGL_WIN;
	version = DerelictGL_INTEL;
	version = DerelictGL_REND;
	version = DerelictGL_APPLE;
	version = DerelictGL_SUNX;
	version = DerelictGL_SUN;
	version = DerelictGL_INGR;
	version = DerelictGL_MESA;
	version = DerelictGL_3DFX;
	version = DerelictGL_OML;
	version = DerelictGL_S3;
	version = DerelictGL_OES;
	version = DerelictGL_GREMEDY;
	version = DerelictGL_MESAX;
	version = DerelictGL_I3D;
	version = DerelictGL_3DL;
}
private 
{
	string extStr;
	version (Windows)
	{
		string winExtStr;
	}
	GLExtensionState[string] loaded;
}
package 
{
	void extLoadAll()
	{
		extLoadCommon();
		extLoadPlatform();
	}

	string[] getLoadedExtensionNames()
	{
		auto keys = loaded.keys;
		string[] ret;
		foreach (key; keys)
		{
			if (GLExtensionState.Loaded == loaded[key])
				ret ~= key;
		}
		ret.sort;
		return ret;
	}

	string[] getNotLoadedExtensionNames()
	{
		auto keys = loaded.keys;
		string[] ret;
		foreach (key; keys)
		{
			GLExtensionState state = loaded[key];
			if (GLExtensionState.Loaded != state)
			{
				if (GLExtensionState.DriverUnsupported == state)
					ret ~= key ~ " (Unsupported by Driver)";
				else
					ret ~= key ~ " (Failed to Load)";
			}
		}
		ret.sort;
		return ret;
	}

	bool extIsSupported(string extName)
	{
		if (extStr is null)
			extStr = toDString(glGetString(GL_EXTENSIONS));
		auto index = extStr.findStr(extName);
		bool verify(string s)
		{
			auto idx = index + extName.length;
			if (idx >= s.length || s[idx] == ' ' || s[idx] == '\x00')
				return true;
			return false;
		}

		bool found;
		if (index != -1)
			found = verify(extStr);
		version (Windows)
		{
			if (!found && winExtStr !is null)
			{
				index = winExtStr.findStr(extName);
				if (index != -1)
					found = verify(winExtStr);
			}
		}

		return found;
	}

	GLExtensionState extGetState(string extName)
	{
		GLExtensionState* state = extName in loaded;
		return state !is null ? *state : GLExtensionState.DerelictUnsupported;
	}

}
private 
{
	void extLoadCommon()
	{
		version (DerelictGL_ARB)
		{
			loaded["GL_ARB_multitexture"] = load_GL_ARB_multitexture();
			loaded["GL_ARB_transpose_matrix"] = load_GL_ARB_transpose_matrix();
			loaded["GL_ARB_multisample"] = load_GL_ARB_multisample();
			loaded["GL_ARB_texture_env_add"] = load_GL_ARB_texture_env_add();
			loaded["GL_ARB_texture_cube_map"] = load_GL_ARB_texture_cube_map();
			loaded["GL_ARB_texture_compression"] = load_GL_ARB_texture_compression();
			loaded["GL_ARB_texture_border_clamp"] = load_GL_ARB_texture_border_clamp();
			loaded["GL_ARB_point_parameters"] = load_GL_ARB_point_parameters();
			loaded["GL_ARB_vertex_blend"] = load_GL_ARB_vertex_blend();
			loaded["GL_ARB_matrix_palette"] = load_GL_ARB_matrix_palette();
			loaded["GL_ARB_texture_env_combine"] = load_GL_ARB_texture_env_combine();
			loaded["GL_ARB_texture_env_crossbar"] = load_GL_ARB_texture_env_crossbar();
			loaded["GL_ARB_texture_env_dot3"] = load_GL_ARB_texture_env_dot3();
			loaded["GL_ARB_texture_mirrored_repeat"] = load_GL_ARB_texture_mirrored_repeat();
			loaded["GL_ARB_depth_texture"] = load_GL_ARB_depth_texture();
			loaded["GL_ARB_shadow"] = load_GL_ARB_shadow();
			loaded["GL_ARB_shadow_ambient"] = load_GL_ARB_shadow_ambient();
			loaded["GL_ARB_window_pos"] = load_GL_ARB_window_pos();
			loaded["GL_ARB_vertex_program"] = load_GL_ARB_vertex_program();
			loaded["GL_ARB_fragment_program"] = load_GL_ARB_fragment_program();
			loaded["GL_ARB_vertex_buffer_object"] = load_GL_ARB_vertex_buffer_object();
			loaded["GL_ARB_occlusion_query"] = load_GL_ARB_occlusion_query();
			loaded["GL_ARB_shader_objects"] = load_GL_ARB_shader_objects();
			loaded["GL_ARB_vertex_shader"] = load_GL_ARB_vertex_shader();
			loaded["GL_ARB_fragment_shader"] = load_GL_ARB_fragment_shader();
			loaded["GL_ARB_shading_language_100"] = load_GL_ARB_shading_language_100();
			loaded["GL_ARB_texture_non_power_of_two"] = load_GL_ARB_texture_non_power_of_two();
			loaded["GL_ARB_point_sprite"] = load_GL_ARB_point_sprite();
			loaded["GL_ARB_fragment_program_shadow"] = load_GL_ARB_fragment_program_shadow();
			loaded["GL_ARB_draw_buffers"] = load_GL_ARB_draw_buffers();
			loaded["GL_ARB_texture_rectangle"] = load_GL_ARB_texture_rectangle();
			loaded["GL_ARB_color_buffer_float"] = load_GL_ARB_color_buffer_float();
			loaded["GL_ARB_half_float_pixel"] = load_GL_ARB_half_float_pixel();
			loaded["GL_ARB_texture_float"] = load_GL_ARB_texture_float();
			loaded["GL_ARB_pixel_buffer_object"] = load_GL_ARB_pixel_buffer_object();
			loaded["GL_ARB_depth_buffer_float"] = load_GL_ARB_depth_buffer_float();
			loaded["GL_ARB_draw_instanced"] = load_GL_ARB_draw_instanced();
			loaded["GL_ARB_framebuffer_object"] = load_GL_ARB_framebuffer_object();
			loaded["GL_ARB_framebuffer_sRGB"] = load_GL_ARB_framebuffer_sRGB();
			loaded["GL_ARB_geometry_shader4"] = load_GL_ARB_geometry_shader4();
			loaded["GL_ARB_half_float_vertex"] = load_GL_ARB_half_float_vertex();
			loaded["GL_ARB_imaging"] = load_GL_ARB_imaging();
			loaded["GL_ARB_instanced_arrays"] = load_GL_ARB_instanced_arrays();
			loaded["GL_ARB_texture_buffer_object"] = load_GL_ARB_texture_buffer_object();
			loaded["GL_ARB_texture_compression_rgtc"] = load_GL_ARB_texture_compression_rgtc();
			loaded["GL_ARB_texture_rg"] = load_GL_ARB_texture_rg();
			loaded["GL_ARB_vertex_array_object"] = load_GL_ARB_vertex_array_object();
			loaded["GL_ARB_copy_buffer"] = load_GL_ARB_copy_buffer();
			loaded["GL_ARB_uniform_buffer_object"] = load_GL_ARB_uniform_buffer_object();
			loaded["GL_ARB_vertex_array_bgra"] = load_GL_ARB_vertex_array_bgra();
			loaded["GL_ARB_draw_elements_base_vertex"] = load_GL_ARB_draw_elements_base_vertex();
			loaded["GL_ARB_vertex_attrib_64bit"] = load_GL_ARB_vertex_attrib_64bit();
			loaded["GL_ARB_provoking_vertex"] = load_GL_ARB_provoking_vertex();
			loaded["GL_ARB_sync"] = load_GL_ARB_sync();
			loaded["GL_ARB_texture_multisample"] = load_GL_ARB_texture_multisample();
			loaded["GL_ARB_viewport_array"] = load_GL_ARB_viewport_array();
			loaded["GL_ARB_cl_event"] = load_GL_ARB_cl_event();
			loaded["GL_ARB_debug_output"] = load_GL_ARB_debug_output();
			loaded["GL_ARB_robustness"] = load_GL_ARB_robustness();
			loaded["GL_ARB_shader_stencil_export"] = load_GL_ARB_shader_stencil_export();
			loaded["GL_ARB_compatibility"] = load_GL_ARB_compatibility();
			loaded["GL_ARB_depth_clamp"] = load_GL_ARB_depth_clamp();
			loaded["GL_ARB_blend_func_extended"] = load_GL_ARB_blend_func_extended();
			loaded["GL_ARB_sampler_objects"] = load_GL_ARB_sampler_objects();
			loaded["GL_ARB_timer_query"] = load_GL_ARB_timer_query();
		}

		version (DerelictGL_EXT)
		{
			loaded["GL_EXT_abgr"] = load_GL_EXT_abgr();
			loaded["GL_EXT_blend_color"] = load_GL_EXT_blend_color();
			loaded["GL_EXT_polygon_offset"] = load_GL_EXT_polygon_offset();
			loaded["GL_EXT_texture"] = load_GL_EXT_texture();
			loaded["GL_EXT_texture3D"] = load_GL_EXT_texture3D();
			loaded["GL_EXT_subtexture"] = load_GL_EXT_subtexture();
			loaded["GL_EXT_copy_texture"] = load_GL_EXT_copy_texture();
			loaded["GL_EXT_histogram"] = load_GL_EXT_histogram();
			loaded["GL_EXT_convolution"] = load_GL_EXT_convolution();
			loaded["GL_EXT_cmyka"] = load_GL_EXT_cmyka();
			loaded["GL_EXT_texture_object"] = load_GL_EXT_texture_object();
			loaded["GL_EXT_packed_pixels"] = load_GL_EXT_packed_pixels();
			loaded["GL_EXT_rescale_normal"] = load_GL_EXT_rescale_normal();
			loaded["GL_EXT_vertex_array"] = load_GL_EXT_vertex_array();
			loaded["GL_EXT_misc_attribute"] = load_GL_EXT_misc_attribute();
			loaded["GL_EXT_blend_minmax"] = load_GL_EXT_blend_minmax();
			loaded["GL_EXT_blend_subtract"] = load_GL_EXT_blend_subtract();
			loaded["GL_EXT_blend_logic_op"] = load_GL_EXT_blend_logic_op();
			loaded["GL_EXT_point_parameters"] = load_GL_EXT_point_parameters();
			loaded["GL_EXT_color_subtable"] = load_GL_EXT_color_subtable();
			loaded["GL_EXT_paletted_texture"] = load_GL_EXT_paletted_texture();
			loaded["GL_EXT_clip_volume_hint"] = load_GL_EXT_clip_volume_hint();
			loaded["GL_EXT_index_texture"] = load_GL_EXT_index_texture();
			loaded["GL_EXT_index_material"] = load_GL_EXT_index_material();
			loaded["GL_EXT_index_func"] = load_GL_EXT_index_func();
			loaded["GL_EXT_index_array_formats"] = load_GL_EXT_index_array_formats();
			loaded["GL_EXT_compiled_vertex_array"] = load_GL_EXT_compiled_vertex_array();
			loaded["GL_EXT_cull_vertex"] = load_GL_EXT_cull_vertex();
			loaded["GL_EXT_draw_range_elements"] = load_GL_EXT_draw_range_elements();
			loaded["GL_EXT_light_texture"] = load_GL_EXT_light_texture();
			loaded["GL_EXT_bgra"] = load_GL_EXT_bgra();
			loaded["GL_EXT_pixel_transform"] = load_GL_EXT_pixel_transform();
			loaded["GL_EXT_pixel_transform_color_table"] = load_GL_EXT_pixel_transform_color_table();
			loaded["GL_EXT_shared_texture_palette"] = load_GL_EXT_shared_texture_palette();
			loaded["GL_EXT_separate_specular_color"] = load_GL_EXT_separate_specular_color();
			loaded["GL_EXT_secondary_color"] = load_GL_EXT_secondary_color();
			loaded["GL_EXT_texture_perturb_normal"] = load_GL_EXT_texture_perturb_normal();
			loaded["GL_EXT_multi_draw_arrays"] = load_GL_EXT_multi_draw_arrays();
			loaded["GL_EXT_fog_coord"] = load_GL_EXT_fog_coord();
			loaded["GL_EXT_coordinate_frame"] = load_GL_EXT_coordinate_frame();
			loaded["GL_EXT_texture_env_combine"] = load_GL_EXT_texture_env_combine();
			loaded["GL_EXT_blend_func_separate"] = load_GL_EXT_blend_func_separate();
			loaded["GL_EXT_stencil_wrap"] = load_GL_EXT_stencil_wrap();
			loaded["GL_EXT_422_pixels"] = load_GL_EXT_422_pixels();
			loaded["GL_EXT_texture_cube_map"] = load_GL_EXT_texture_cube_map();
			loaded["GL_EXT_texture_env_add"] = load_GL_EXT_texture_env_add();
			loaded["GL_EXT_texture_lod_bias"] = load_GL_EXT_texture_lod_bias();
			loaded["GL_EXT_texture_filter_anisotropic"] = load_GL_EXT_texture_filter_anisotropic();
			loaded["GL_EXT_vertex_weighting"] = load_GL_EXT_vertex_weighting();
			loaded["GL_EXT_texture_compression_s3tc"] = load_GL_EXT_texture_compression_s3tc();
			loaded["GL_EXT_multisample"] = load_GL_EXT_multisample();
			loaded["GL_EXT_texture_env_dot3"] = load_GL_EXT_texture_env_dot3();
			loaded["GL_EXT_vertex_shader"] = load_GL_EXT_vertex_shader();
			loaded["GL_EXT_shadow_funcs"] = load_GL_EXT_shadow_funcs();
			loaded["GL_EXT_stencil_two_side"] = load_GL_EXT_stencil_two_side();
			loaded["GL_EXT_depth_bounds_test"] = load_GL_EXT_depth_bounds_test();
			loaded["GL_EXT_texture_mirror_clamp"] = load_GL_EXT_texture_mirror_clamp();
			loaded["GL_EXT_blend_equation_separate"] = load_GL_EXT_blend_equation_separate();
			loaded["GL_EXT_pixel_buffer_object"] = load_GL_EXT_pixel_buffer_object();
			loaded["GL_EXT_framebuffer_object"] = load_GL_EXT_framebuffer_object();
			loaded["GL_EXT_packed_depth_stencil"] = load_GL_EXT_packed_depth_stencil();
			loaded["GL_EXT_stencil_clear_tag"] = load_GL_EXT_stencil_clear_tag();
			loaded["GL_EXT_texture_sRGB"] = load_GL_EXT_texture_sRGB();
			loaded["GL_EXT_framebuffer_blit"] = load_GL_EXT_framebuffer_blit();
			loaded["GL_EXT_framebuffer_multisample"] = load_GL_EXT_framebuffer_multisample();
			loaded["GL_EXT_timer_query"] = load_GL_EXT_timer_query();
			loaded["GL_EXT_gpu_program_parameters"] = load_GL_EXT_gpu_program_parameters();
			loaded["GL_EXT_geometry_shader4"] = load_GL_EXT_geometry_shader4();
			loaded["GL_EXT_gpu_shader4"] = load_GL_EXT_gpu_shader4();
			loaded["GL_EXT_draw_instanced"] = load_GL_EXT_draw_instanced();
			loaded["GL_EXT_packed_float"] = load_GL_EXT_packed_float();
			loaded["GL_EXT_texture_array"] = load_GL_EXT_texture_array();
			loaded["GL_EXT_texture_buffer_object"] = load_GL_EXT_texture_buffer_object();
			loaded["GL_EXT_texture_compression_latc"] = load_GL_EXT_texture_compression_latc();
			loaded["GL_EXT_texture_compression_rgtc"] = load_GL_EXT_texture_compression_rgtc();
			loaded["GL_EXT_texture_shared_exponent"] = load_GL_EXT_texture_shared_exponent();
			loaded["GL_EXT_framebuffer_sRGB"] = load_GL_EXT_framebuffer_sRGB();
			loaded["GL_EXT_draw_buffers2"] = load_GL_EXT_draw_buffers2();
			loaded["GL_EXT_bindable_uniform"] = load_GL_EXT_bindable_uniform();
			loaded["GL_EXT_texture_integer"] = load_GL_EXT_texture_integer();
			loaded["GL_EXT_transform_feedback"] = load_GL_EXT_transform_feedback();
			loaded["GL_EXT_direct_state_access"] = load_GL_EXT_direct_state_access();
			loaded["GL_EXT_vertex_array_bgra"] = load_GL_EXT_vertex_array_bgra();
			loaded["GL_EXT_texture_swizzle"] = load_GL_EXT_texture_swizzle();
			loaded["GL_EXT_provoking_vertex"] = load_GL_EXT_provoking_vertex();
			loaded["GL_EXT_texture_snorm"] = load_GL_EXT_texture_snorm();
			loaded["GL_EXT_separate_shader_objects"] = load_GL_EXT_separate_shader_objects();
		}

		version (DerelictGL_NV)
		{
			loaded["GL_NV_texgen_reflection"] = load_GL_NV_texgen_reflection();
			loaded["GL_NV_light_max_exponent"] = load_GL_NV_light_max_exponent();
			loaded["GL_NV_vertex_array_range"] = load_GL_NV_vertex_array_range();
			loaded["GL_NV_register_combiners"] = load_GL_NV_register_combiners();
			loaded["GL_NV_fog_distance"] = load_GL_NV_fog_distance();
			loaded["GL_NV_texgen_emboss"] = load_GL_NV_texgen_emboss();
			loaded["GL_NV_blend_square"] = load_GL_NV_blend_square();
			loaded["GL_NV_texture_env_combine4"] = load_GL_NV_texture_env_combine4();
			loaded["GL_NV_fence"] = load_GL_NV_fence();
			loaded["GL_NV_evaluators"] = load_GL_NV_evaluators();
			loaded["GL_NV_packed_depth_stencil"] = load_GL_NV_packed_depth_stencil();
			loaded["GL_NV_register_combiners2"] = load_GL_NV_register_combiners2();
			loaded["GL_NV_texture_compression_vtc"] = load_GL_NV_texture_compression_vtc();
			loaded["GL_NV_texture_rectangle"] = load_GL_NV_texture_rectangle();
			loaded["GL_NV_texture_shader"] = load_GL_NV_texture_shader();
			loaded["GL_NV_texture_shader2"] = load_GL_NV_texture_shader2();
			loaded["GL_NV_vertex_array_range2"] = load_GL_NV_vertex_array_range2();
			loaded["GL_NV_vertex_program"] = load_GL_NV_vertex_program();
			loaded["GL_NV_copy_depth_to_color"] = load_GL_NV_copy_depth_to_color();
			loaded["GL_NV_multisample_filter_hint"] = load_GL_NV_multisample_filter_hint();
			loaded["GL_NV_depth_clamp"] = load_GL_NV_depth_clamp();
			loaded["GL_NV_occlusion_query"] = load_GL_NV_occlusion_query();
			loaded["GL_NV_point_sprite"] = load_GL_NV_point_sprite();
			loaded["GL_NV_texture_shader3"] = load_GL_NV_texture_shader3();
			loaded["GL_NV_vertex_program1_1"] = load_GL_NV_vertex_program1_1();
			loaded["GL_NV_float_buffer"] = load_GL_NV_float_buffer();
			loaded["GL_NV_fragment_program"] = load_GL_NV_fragment_program();
			loaded["GL_NV_half_float"] = load_GL_NV_half_float();
			loaded["GL_NV_pixel_data_range"] = load_GL_NV_pixel_data_range();
			loaded["GL_NV_primitive_restart"] = load_GL_NV_primitive_restart();
			loaded["GL_NV_texture_expand_normal"] = load_GL_NV_texture_expand_normal();
			loaded["GL_NV_vertex_program2"] = load_GL_NV_vertex_program2();
			loaded["GL_NV_fragment_program_option"] = load_GL_NV_fragment_program_option();
			loaded["GL_NV_fragment_program2"] = load_GL_NV_fragment_program2();
			loaded["GL_NV_vertex_program2_option"] = load_GL_NV_vertex_program2_option();
			loaded["GL_NV_vertex_program3"] = load_GL_NV_vertex_program3();
			loaded["GL_NV_gpu_program4"] = load_GL_NV_gpu_program4();
			loaded["GL_NV_geometry_program4"] = load_GL_NV_geometry_program4();
			loaded["GL_NV_vertex_program4"] = load_GL_NV_vertex_program4();
			loaded["GL_NV_depth_buffer_float"] = load_GL_NV_depth_buffer_float();
			loaded["GL_NV_fragment_program4"] = load_GL_NV_fragment_program4();
			loaded["GL_NV_framebuffer_multisample_coverage"] = load_GL_NV_framebuffer_multisample_coverage();
			loaded["GL_NV_geometry_shader4"] = load_GL_NV_geometry_shader4();
			loaded["GL_NV_transform_feedback"] = load_GL_NV_transform_feedback();
			loaded["GL_NV_conditional_render"] = load_GL_NV_conditional_render();
			loaded["GL_NV_present_video"] = load_GL_NV_present_video();
			loaded["GL_NV_explicit_multisample"] = load_GL_NV_explicit_multisample();
			loaded["GL_NV_transform_feedback2"] = load_GL_NV_transform_feedback2();
			loaded["GL_NV_video_capture"] = load_GL_NV_video_capture();
			loaded["GL_NV_copy_image"] = load_GL_NV_copy_image();
			loaded["GL_NV_parameter_buffer_object2"] = load_GL_NV_parameter_buffer_object2();
			loaded["GL_NV_shader_buffer_load"] = load_GL_NV_shader_buffer_load();
			loaded["GL_NV_vertex_buffer_unified_memory"] = load_GL_NV_vertex_buffer_unified_memory();
			loaded["GL_NV_texture_barrier"] = load_GL_NV_texture_barrier();
		}

		version (DerelictGL_ATI)
		{
			loaded["GL_ATI_texture_mirror_once"] = load_GL_ATI_texture_mirror_once();
			loaded["GL_ATI_envmap_bumpmap"] = load_GL_ATI_envmap_bumpmap();
			loaded["GL_ATI_fragment_shader"] = load_GL_ATI_fragment_shader();
			loaded["GL_ATI_pn_triangles"] = load_GL_ATI_pn_triangles();
			loaded["GL_ATI_vertex_array_object"] = load_GL_ATI_vertex_array_object();
			loaded["GL_ATI_vertex_streams"] = load_GL_ATI_vertex_streams();
			loaded["GL_ATI_element_array"] = load_GL_ATI_element_array();
			loaded["GL_ATI_text_fragment_shader"] = load_GL_ATI_text_fragment_shader();
			loaded["GL_ATI_draw_buffers"] = load_GL_ATI_draw_buffers();
			loaded["GL_ATI_pixel_format_float"] = load_GL_ATI_pixel_format_float();
			loaded["GL_ATI_texture_env_combine3"] = load_GL_ATI_texture_env_combine3();
			loaded["GL_ATI_texture_float"] = load_GL_ATI_texture_float();
			loaded["GL_ATI_map_object_buffer"] = load_GL_ATI_map_object_buffer();
			loaded["GL_ATI_separate_stencil"] = load_GL_ATI_separate_stencil();
			loaded["GL_ATI_vertex_attrib_array_object"] = load_GL_ATI_vertex_attrib_array_object();
			loaded["GL_ATI_meminfo"] = load_GL_ATI_meminfo();
		}

		version (DerelictGL_AMD)
		{
			loaded["GL_AMD_performance_monitor"] = load_GL_AMD_performance_monitor();
			loaded["GL_AMD_texture_texture4"] = load_GL_AMD_texture_texture4();
			loaded["GL_AMD_vertex_shader_tesselator"] = load_GL_AMD_vertex_shader_tesselator();
			loaded["GL_AMD_draw_buffers_blend"] = load_GL_AMD_draw_buffers_blend();
		}

		version (DerelictGL_SGI)
		{
			loaded["GL_SGI_color_matrix"] = load_GL_SGI_color_matrix();
			loaded["GL_SGI_color_table"] = load_GL_SGI_color_table();
			loaded["GL_SGI_texture_color_table"] = load_GL_SGI_texture_color_table();
		}

		version (DerelictGL_SGIS)
		{
			loaded["GL_SGIS_texture_filter4"] = load_GL_SGIS_texture_filter4;
			loaded["GL_SGIS_pixel_texture"] = load_GL_SGIS_pixel_texture();
			loaded["GL_SGIS_texture4D"] = load_GL_SGIS_texture4D();
			loaded["GL_SGIS_detail_texture"] = load_GL_SGIS_detail_texture();
			loaded["GL_SGIS_sharpen_texture"] = load_GL_SGIS_sharpen_texture();
			loaded["GL_SGIS_texture_lod"] = load_GL_SGIS_texture_lod();
			loaded["GL_SGIS_multisample"] = load_GL_SGIS_multisample();
			loaded["GL_SGIS_generate_mipmap"] = load_GL_SGIS_generate_mipmap();
			loaded["GL_SGIS_texture_edge_clamp"] = load_GL_SGIS_texture_edge_clamp();
			loaded["GL_SGIS_texture_border_clamp"] = load_GL_SGIS_texture_border_clamp();
			loaded["GL_SGIS_texture_select"] = load_GL_SGIS_texture_select();
			loaded["GL_SGIS_point_parameters"] = load_GL_SGIS_point_parameters();
			loaded["GL_SGIS_fog_function"] = load_GL_SGIS_fog_function();
			loaded["GL_SGIS_point_line_texgen"] = load_GL_SGIS_point_line_texgen();
			loaded["GL_SGIS_texture_color_mask"] = load_GL_SGIS_texture_color_mask();
		}

		version (DerelictGL_SGIX)
		{
			loaded["GL_SGIX_pixel_texture"] = load_GL_SGIX_pixel_texture();
			loaded["GL_SGIX_clipmap"] = load_GL_SGIX_clipmap();
			loaded["GL_SGIX_shadow"] = load_GL_SGIX_shadow();
			loaded["GL_SGIX_interlace"] = load_GL_SGIX_interlace();
			loaded["GL_SGIX_pixel_tiles"] = load_GL_SGIX_pixel_tiles();
			loaded["GL_SGIX_sprite"] = load_GL_SGIX_sprite();
			loaded["GL_SGIX_texture_multi_buffer"] = load_GL_SGIX_texture_multi_buffer();
			loaded["GL_SGIX_instruments"] = load_GL_SGIX_instruments();
			loaded["GL_SGIX_texture_scale_bias"] = load_GL_SGIX_texture_scale_bias();
			loaded["GL_SGIX_framezoom"] = load_GL_SGIX_framezoom();
			loaded["GL_SGIX_tag_sample_buffer"] = load_GL_SGIX_tag_sample_buffer();
			loaded["GL_SGIX_polynomial_ffd"] = load_GL_SGIX_polynomial_ffd();
			loaded["GL_SGIX_reference_plane"] = load_GL_SGIX_reference_plane();
			loaded["GL_SGIX_flush_raster"] = load_GL_SGIX_flush_raster();
			loaded["GL_SGIX_depth_texture"] = load_GL_SGIX_depth_texture();
			loaded["GL_SGIX_fog_offset"] = load_GL_SGIX_fog_offset();
			loaded["GL_SGIX_texture_add_env"] = load_GL_SGIX_texture_add_env();
			loaded["GL_SGIX_list_priority"] = load_GL_SGIX_list_priority();
			loaded["GL_SGIX_ir_instrument1"] = load_GL_SGIX_ir_instrument1();
			loaded["GL_SGIX_calligraphic_fragment"] = load_GL_SGIX_calligraphic_fragment();
			loaded["GL_SGIX_texture_lod_bias"] = load_GL_SGIX_texture_lod_bias();
			loaded["GL_SGIX_shadow_ambient"] = load_GL_SGIX_shadow_ambient();
			loaded["GL_SGIX_ycrcb"] = load_GL_SGIX_ycrcb();
			loaded["GL_SGIX_fragment_lighting"] = load_GL_SGIX_fragment_lighting();
			loaded["GL_SGIX_blend_alpha_minmax"] = load_GL_SGIX_blend_alpha_minmax();
			loaded["GL_SGIX_impact_pixel_texture"] = load_GL_SGIX_impact_pixel_texture();
			loaded["GL_SGIX_async"] = load_GL_SGIX_async();
			loaded["GL_SGIX_async_pixel"] = load_GL_SGIX_async_pixel();
			loaded["GL_SGIX_async_histogram"] = load_GL_SGIX_async_histogram();
			loaded["GL_SGIX_fog_scale"] = load_GL_SGIX_fog_scale();
			loaded["GL_SGIX_subsample"] = load_GL_SGIX_subsample();
			loaded["GL_SGIX_ycrcb_subsample"] = load_GL_SGIX_ycrcb_subsample();
			loaded["GL_SGIX_ycrcba"] = load_GL_SGIX_ycrcba();
			loaded["GL_SGIX_depth_pass_instrument"] = load_GL_SGIX_depth_pass_instrument();
			loaded["GL_SGIX_vertex_preclip"] = load_GL_SGIX_vertex_preclip();
			loaded["GL_SGIX_convolution_accuracy"] = load_GL_SGIX_convolution_accuracy();
			loaded["GL_SGIX_resample"] = load_GL_SGIX_resample();
			loaded["GL_SGIX_texture_coordinate_clamp"] = load_GL_SGIX_texture_coordinate_clamp();
			loaded["GL_SGIX_scalebias_hint"] = load_GL_SGIX_scalebias_hint();
		}

		version (DerelictGL_HP)
		{
			loaded["GL_HP_image_transform"] = load_GL_HP_image_transform();
			loaded["GL_HP_convolution_border_modes"] = load_GL_HP_convolution_border_modes();
			loaded["GL_HP_texture_lighting"] = load_GL_HP_texture_lighting();
			loaded["GL_HP_occlusion_test"] = load_GL_HP_occlusion_test();
		}

		version (DerelictGL_PGI)
		{
			loaded["GL_PGI_vertex_hints"] = load_GL_PGI_vertex_hints();
			loaded["GL_PGI_misc_hints"] = load_GL_PGI_misc_hints();
		}

		version (DerelictGL_IBM)
		{
			loaded["GL_IBM_rasterpos_clip"] = load_GL_IBM_rasterpos_clip();
			loaded["GL_IBM_cull_vertex"] = load_GL_IBM_cull_vertex();
			loaded["GL_IBM_multimode_draw_arrays"] = load_GL_IBM_multimode_draw_arrays();
			loaded["GL_IBM_vertex_array_lists"] = load_GL_IBM_vertex_array_lists();
			loaded["GL_IBM_texture_mirrored_repeat"] = load_GL_IBM_texture_mirrored_repeat();
		}

		version (DerelictGL_WIN)
		{
			loaded["GL_WIN_phong_shading"] = load_GL_WIN_phong_shading();
			loaded["GL_WIN_specular_fog"] = load_GL_WIN_specular_fog();
		}

		version (DerelictGL_INTEL)
		{
			loaded["GL_INTEL_parallel_arrays"] = load_GL_INTEL_parallel_arrays();
		}

		version (DerelictGL_REND)
		{
			loaded["GL_REND_screen_coordinates"] = load_GL_REND_screen_coordinates();
		}

		version (DerelictGL_APPLE)
		{
			loaded["GL_APPLE_specular_vector"] = load_GL_APPLE_specular_vector();
			loaded["GL_APPLE_transform_hint"] = load_GL_APPLE_transform_hint();
			loaded["GL_APPLE_client_storage"] = load_GL_APPLE_client_storage();
			loaded["GL_APPLE_element_array"] = load_GL_APPLE_element_array();
			loaded["GL_APPLE_fence"] = load_GL_APPLE_fence();
			loaded["GL_APPLE_vertex_array_object"] = load_GL_APPLE_vertex_array_object();
			loaded["GL_APPLE_vertex_array_range"] = load_GL_APPLE_vertex_array_range();
			loaded["GL_APPLE_ycbcr_422"] = load_GL_APPLE_ycbcr_422();
			loaded["GL_APPLE_flush_buffer_range"] = load_GL_APPLE_flush_buffer_range();
			loaded["GL_APPLE_texture_range"] = load_GL_APPLE_texture_range();
			loaded["GL_APPLE_float_pixels"] = load_GL_APPLE_float_pixels();
			loaded["GL_APPLE_vertex_program_evaluators"] = load_GL_APPLE_vertex_program_evaluators();
			loaded["GL_APPLE_aux_depth_stencil"] = load_GL_APPLE_aux_depth_stencil();
			loaded["GL_APPLE_object_purgeable"] = load_GL_APPLE_object_purgeable();
			loaded["GL_APPLE_row_bytes"] = load_GL_APPLE_row_bytes();
			loaded["GL_APPLE_rgb_422"] = load_GL_APPLE_rgb_422();
		}

		version (DerelictGL_SUNX)
		{
			loaded["GL_SUNX_constant_data"] = load_GL_SUNX_constant_data();
		}

		version (DerelictGL_SUN)
		{
			loaded["GL_SUN_global_alpha"] = load_GL_SUN_global_alpha();
			loaded["GL_SUN_triangle_list"] = load_GL_SUN_triangle_list();
			loaded["GL_SUN_vertex"] = load_GL_SUN_vertex();
			loaded["GL_SUN_convolution_border_modes"] = load_GL_SUN_convolution_border_modes();
			loaded["GL_SUN_mesh_array"] = load_GL_SUN_mesh_array();
			loaded["GL_SUN_slice_accum"] = load_GL_SUN_slice_accum();
		}

		version (DerelictGL_INGR)
		{
			loaded["GL_INGR_color_clamp"] = load_GL_INGR_color_clamp();
			loaded["GL_INGR_interlace_read"] = load_GL_INGR_interlace_read();
		}

		version (DerelictGL_MESA)
		{
			loaded["GL_MESA_resize_buffers"] = load_GL_MESA_resize_buffers();
			loaded["GL_MESA_window_pos"] = load_GL_MESA_window_pos();
			loaded["GL_MESA_pack_invert"] = load_GL_MESA_pack_invert();
			loaded["GL_MESA_ycbcr_texture"] = load_GL_MESA_ycbcr_texture();
		}

		version (DerelictGL_3DFX)
		{
			loaded["GL_3DFX_texture_compression_FXT1"] = load_GL_3DFX_texture_compression_FXT1();
			loaded["GL_3DFX_multisample"] = load_GL_3DFX_multisample();
			loaded["GL_3DFX_tbuffer"] = load_GL_3DFX_tbuffer();
		}

		version (DerelictGL_OML)
		{
			loaded["GL_OML_interlace"] = load_GL_OML_interlace();
			loaded["GL_OML_subsample"] = load_GL_OML_subsample();
			loaded["GL_OML_resample"] = load_GL_OML_resample();
		}

		version (DerelictGL_S3)
		{
			loaded["GL_S3_s3tc"] = load_GL_S3_s3tc();
		}

		version (DerelictGL_OES)
		{
			loaded["GL_OES_read_format"] = load_GL_OES_read_format();
		}

		version (DerelictGL_GREMEDY)
		{
			loaded["GL_GREMEDY_string_marker"] = load_GL_GREMEDY_string_marker();
			loaded["GL_GREMEDY_frame_terminator"] = load_GL_GREMEDY_frame_terminator();
		}

		version (DerelictGL_MESAX)
		{
			loaded["GL_MESAX_texture_stack"] = load_GL_MESAX_texture_stack();
		}

	}

	void extLoadPlatform()
	{
		version (Windows)
		{
			loaded["WGL_ARB_extensions_string"] = load_WGL_ARB_extensions_string();
			loaded["WGL_EXT_extensions_string"] = load_WGL_EXT_extensions_string();
			if (wglGetExtensionsStringARB !is null)
			{
				HDC dc = wglGetCurrentDC();
				if (dc !is null)
					winExtStr = toDString(wglGetExtensionsStringARB(dc));
				else
					throw new DerelictException("Cannot load WGL extensions: No valid Device Context!");
			}
			else
				if (wglGetExtensionsStringEXT !is null)
				{
					winExtStr = toDString(wglGetExtensionsStringEXT());
				}
			if (winExtStr is null || winExtStr == "")
				return ;
			version (DerelictGL_ARB)
			{
				loaded["WGL_ARB_buffer_region"] = load_WGL_ARB_buffer_region();
				loaded["WGL_ARB_multisample"] = load_WGL_ARB_multisample();
				loaded["WGL_ARB_pixel_format"] = load_WGL_ARB_pixel_format();
				loaded["WGL_ARB_make_current_read"] = load_WGL_ARB_make_current_read();
				loaded["WGL_ARB_pbuffer"] = load_WGL_ARB_pbuffer();
				loaded["WGL_ARB_render_texture"] = load_WGL_ARB_render_texture();
				loaded["WGL_ARB_pixel_format_float"] = load_WGL_ARB_pixel_format_float();
				loaded["WGL_ARB_create_context"] = load_WGL_ARB_create_context();
				loaded["WGL_ARB_create_context_profile"] = load_WGL_ARB_create_context_profile();
				loaded["WGL_ARB_framebuffer_sRGB"] = load_WGL_ARB_framebuffer_sRGB();
			}

			version (DerelictGL_EXT)
			{
				loaded["WGL_EXT_depth_float"] = load_WGL_EXT_depth_float();
				loaded["WGL_EXT_display_color_table"] = load_WGL_EXT_display_color_table();
				loaded["WGL_EXT_framebuffer_sRGB"] = load_WGL_EXT_framebuffer_sRGB();
				loaded["WGL_EXT_make_current_read"] = load_WGL_EXT_make_current_read();
				loaded["WGL_EXT_multisample"] = load_WGL_EXT_multisample();
				loaded["WGL_EXT_pbuffer"] = load_WGL_EXT_pbuffer();
				loaded["WGL_EXT_pixel_format"] = load_WGL_EXT_pixel_format();
				loaded["WGL_EXT_pixel_format_packed_float"] = load_WGL_EXT_pixel_format_packed_float();
				loaded["WGL_EXT_swap_control"] = load_WGL_EXT_swap_control();
			}

			version (DerelictGL_NV)
			{
				loaded["WGL_NV_copy_image"] = load_WGL_NV_copy_image();
				loaded["WGL_NV_float_buffer"] = load_WGL_NV_float_buffer();
				loaded["WGL_NV_gpu_affinity"] = load_WGL_NV_gpu_affinity();
				loaded["WGL_NV_multisample_coverage"] = load_WGL_NV_multisample_coverage();
				loaded["WGL_NV_present_video"] = load_WGL_NV_present_video();
				loaded["WGL_NV_render_depth_texture"] = load_WGL_NV_render_depth_texture();
				loaded["WGL_NV_render_texture_rectangle"] = load_WGL_NV_render_texture_rectangle();
				loaded["WGL_NV_swap_group"] = load_WGL_NV_swap_group();
				loaded["WGL_NV_vertex_array_range"] = load_WGL_NV_vertex_array_range();
				loaded["WGL_NV_video_output"] = load_WGL_NV_video_output();
			}

			version (DerelictGL_ATI)
			{
				loaded["WGL_ATI_pixel_format_float"] = load_WGL_ATI_pixel_format_float();
				loaded["WGL_ATI_render_texture_rectangle"] = load_WGL_ATI_render_texture_rectangle();
			}

			version (DerelictGL_AMD)
			{
				loaded["WGL_AMD_gpu_association"] = load_WGL_AMD_gpu_association();
			}

			version (DerelictGL_I3D)
			{
				loaded["WGL_I3D_digital_video_control"] = load_WGL_I3D_digital_video_control();
				loaded["WGL_I3D_gamma"] = load_WGL_I3D_gamma();
				loaded["WGL_I3D_genlock"] = load_WGL_I3D_genlock();
				loaded["WGL_I3D_image_buffer"] = load_WGL_I3D_image_buffer();
				loaded["WGL_I3D_swap_frame_lock"] = load_WGL_I3D_swap_frame_lock();
				loaded["WGL_I3D_swap_frame_usage"] = load_WGL_I3D_swap_frame_usage();
			}

			version (DerelictGL_OML)
			{
				loaded["WGL_OML_sync_control"] = load_WGL_OML_sync_control();
			}

			version (DerelictGL_3DFX)
			{
				loaded["WGL_3DFX_multisample"] = load_WGL_3DFX_multisample();
			}

			version (DerelictGL_3DL)
			{
				loaded["WGL_3DL_stereo_control"] = load_WGL_3DL_stereo_control();
			}

		}

	}

	bool bindExtFunc(void** ptr, string funcName)
	{
		version (CGL)
		{
			debug (1)
			{
				bool doThrow = true;
			}
			else
			{
				bool doThrow = false;
			}

			DerelictGL.bindExtendedFunc(ptr, funcName, doThrow);
			return *ptr !is null;
		}
		else
		{
			*ptr = loadGLSymbol(funcName);
			return *ptr !is null;
		}

	}

	version (DerelictGL_ARB)
	{
		GLExtensionState load_GL_ARB_multitexture()
		{
			if (!extIsSupported("GL_ARB_multitexture"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glActiveTextureARB, "glActiveTextureARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glClientActiveTextureARB, "glClientActiveTextureARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord1dARB, "glMultiTexCoord1dARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord1dvARB, "glMultiTexCoord1dvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord1fARB, "glMultiTexCoord1fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord1fvARB, "glMultiTexCoord1fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord1iARB, "glMultiTexCoord1iARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord1ivARB, "glMultiTexCoord1ivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord1sARB, "glMultiTexCoord1sARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord1svARB, "glMultiTexCoord1svARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord2dARB, "glMultiTexCoord2dARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord2dvARB, "glMultiTexCoord2dvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord2fARB, "glMultiTexCoord2fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord2fvARB, "glMultiTexCoord2fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord2iARB, "glMultiTexCoord2iARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord2ivARB, "glMultiTexCoord2ivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord2sARB, "glMultiTexCoord2sARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord2svARB, "glMultiTexCoord2svARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord3dARB, "glMultiTexCoord3dARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord3dvARB, "glMultiTexCoord3dvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord3fARB, "glMultiTexCoord3fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord3fvARB, "glMultiTexCoord3fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord3iARB, "glMultiTexCoord3iARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord3ivARB, "glMultiTexCoord3ivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord3sARB, "glMultiTexCoord3sARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord3svARB, "glMultiTexCoord3svARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord4dARB, "glMultiTexCoord4dARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord4dvARB, "glMultiTexCoord4dvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord4fARB, "glMultiTexCoord4fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord4fvARB, "glMultiTexCoord4fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord4iARB, "glMultiTexCoord4iARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord4ivARB, "glMultiTexCoord4ivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord4sARB, "glMultiTexCoord4sARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord4svARB, "glMultiTexCoord4svARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_transpose_matrix()
		{
			if (!extIsSupported("GL_ARB_transpose_matrix"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glLoadTransposeMatrixfARB, "glLoadTransposeMatrixfARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glLoadTransposeMatrixdARB, "glLoadTransposeMatrixdARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultTransposeMatrixfARB, "glMultTransposeMatrixfARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultTransposeMatrixdARB, "glMultTransposeMatrixdARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_multisample()
		{
			if (!extIsSupported("GL_ARB_multisample"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glSampleCoverageARB, "glSampleCoverageARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_env_add()
		{
			if (!extIsSupported("GL_ARB_texture_env_add"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_cube_map()
		{
			if (!extIsSupported("GL_ARB_texture_cube_map"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_compression()
		{
			if (!extIsSupported("GL_ARB_texture_compression"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glCompressedTexImage3DARB, "glCompressedTexImage3DARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedTexImage2DARB, "glCompressedTexImage2DARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedTexImage1DARB, "glCompressedTexImage1DARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedTexSubImage3DARB, "glCompressedTexSubImage3DARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedTexSubImage2DARB, "glCompressedTexSubImage2DARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedTexSubImage1DARB, "glCompressedTexSubImage1DARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetCompressedTexImageARB, "glGetCompressedTexImageARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_border_clamp()
		{
			if (!extIsSupported("GL_ARB_texture_border_clamp"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_point_parameters()
		{
			if (!extIsSupported("GL_ARB_point_parameters"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glPointParameterfARB, "glPointParameterfARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPointParameterfvARB, "glPointParameterfvARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_vertex_blend()
		{
			if (!extIsSupported("GL_ARB_vertex_blend"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glWeightbvARB, "glWeightbvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWeightsvARB, "glWeightsvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWeightivARB, "glWeightivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWeightfvARB, "glWeightfvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWeightdvARB, "glWeightdvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWeightubvARB, "glMatrixIndexPointerARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWeightusvARB, "glWeightusvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWeightuivARB, "glWeightuivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWeightPointerARB, "glWeightPointerARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexBlendARB, "glVertexBlendARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_matrix_palette()
		{
			if (!extIsSupported("GL_ARB_matrix_palette"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glCurrentPaletteMatrixARB, "glCurrentPaletteMatrixARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixIndexubvARB, "glMatrixIndexubvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixIndexusvARB, "glMatrixIndexusvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixIndexuivARB, "glMatrixIndexuivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixIndexPointerARB, "glMatrixIndexPointerARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_env_combine()
		{
			if (!extIsSupported("GL_ARB_texture_env_combine"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_env_crossbar()
		{
			if (!extIsSupported("GL_ARB_texture_env_crossbar"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_env_dot3()
		{
			if (!extIsSupported("GL_ARB_texture_env_dot3"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_mirrored_repeat()
		{
			if (!extIsSupported("GL_ARB_texture_mirrored_repeat"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_depth_texture()
		{
			if (!extIsSupported("GL_ARB_depth_texture"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_shadow()
		{
			if (!extIsSupported("GL_ARB_shadow"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_shadow_ambient()
		{
			if (!extIsSupported("GL_ARB_shadow_ambient"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_window_pos()
		{
			if (!extIsSupported("GL_ARB_window_pos"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glWindowPos2dARB, "glWindowPos2dARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos2dvARB, "glWindowPos2dvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos2fARB, "glWindowPos2fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos2fvARB, "glWindowPos2fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos2iARB, "glWindowPos2iARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos2ivARB, "glWindowPos2ivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos2sARB, "glWindowPos2sARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos2svARB, "glWindowPos2svARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3dARB, "glWindowPos3dARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3dvARB, "glWindowPos3dvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3fARB, "glWindowPos3fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3fvARB, "glWindowPos3fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3iARB, "glWindowPos3iARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3ivARB, "glWindowPos3ivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3sARB, "glWindowPos3sARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3svARB, "glWindowPos3svARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_vertex_program()
		{
			if (!extIsSupported("GL_ARB_vertex_program"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glVertexAttrib1dARB, "glVertexAttrib1dARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib1dvARB, "glVertexAttrib1dvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib1fARB, "glVertexAttrib1fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib1fvARB, "glVertexAttrib1fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib1sARB, "glVertexAttrib1sARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib1svARB, "glVertexAttrib1svARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib2dARB, "glVertexAttrib2dARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib2dvARB, "glVertexAttrib2dvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib2fARB, "glVertexAttrib2fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib2fvARB, "glVertexAttrib2fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib2sARB, "glVertexAttrib2sARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib2svARB, "glVertexAttrib2svARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib3dARB, "glVertexAttrib3dARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib3dvARB, "glVertexAttrib3dvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib3fARB, "glVertexAttrib3fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib3fvARB, "glVertexAttrib3fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib3sARB, "glVertexAttrib3sARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib3svARB, "glVertexAttrib3svARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4NbvARB, "glVertexAttrib4NbvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4NivARB, "glVertexAttrib4NivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4NsvARB, "glVertexAttrib4NsvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4NubARB, "glVertexAttrib4NubARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4NubvARB, "glVertexAttrib4NubvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4NuivARB, "glVertexAttrib4NuivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4NusvARB, "glVertexAttrib4NusvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4bvARB, "glVertexAttrib4bvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4dARB, "glVertexAttrib4dARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4dvARB, "glVertexAttrib4dvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4fARB, "glVertexAttrib4fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4fvARB, "glVertexAttrib4fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4ivARB, "glVertexAttrib4ivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4sARB, "glVertexAttrib4sARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4svARB, "glVertexAttrib4svARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4ubvARB, "glVertexAttrib4ubvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4uivARB, "glVertexAttrib4uivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4usvARB, "glVertexAttrib4usvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribPointerARB, "glVertexAttribPointerARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEnableVertexAttribArrayARB, "glEnableVertexAttribArrayARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDisableVertexAttribArrayARB, "glDisableVertexAttribArrayARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramStringARB, "glProgramStringARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindProgramARB, "glBindProgramARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteProgramsARB, "glDeleteProgramsARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenProgramsARB, "glGenProgramsARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramEnvParameter4dARB, "glProgramEnvParameter4dARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramEnvParameter4dvARB, "glProgramEnvParameter4dvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramEnvParameter4fARB, "glProgramEnvParameter4fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramEnvParameter4fvARB, "glProgramEnvParameter4fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramLocalParameter4dARB, "glProgramLocalParameter4dARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramLocalParameter4dvARB, "glProgramLocalParameter4dvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramLocalParameter4fARB, "glProgramLocalParameter4fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramLocalParameter4fvARB, "glProgramLocalParameter4fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramEnvParameterdvARB, "glGetProgramEnvParameterdvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramEnvParameterfvARB, "glGetProgramEnvParameterfvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramLocalParameterdvARB, "glGetProgramLocalParameterdvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramLocalParameterfvARB, "glGetProgramLocalParameterfvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramivARB, "glGetProgramivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramStringARB, "glGetProgramStringARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVertexAttribdvARB, "glGetVertexAttribdvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVertexAttribfvARB, "glGetVertexAttribfvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVertexAttribivARB, "glGetVertexAttribivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVertexAttribPointervARB, "glGetVertexAttribPointervARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsProgramARB, "glIsProgramARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_fragment_program()
		{
			if (!extIsSupported("GL_ARB_fragment_program"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_vertex_buffer_object()
		{
			if (!extIsSupported("GL_ARB_vertex_buffer_object"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBindBufferARB, "glBindBufferARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteBuffersARB, "glDeleteBuffersARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenBuffersARB, "glGenBuffersARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsBufferARB, "glIsBufferARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBufferDataARB, "glBufferDataARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBufferSubDataARB, "glBufferSubDataARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetBufferSubDataARB, "glGetBufferSubDataARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMapBufferARB, "glMapBufferARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUnmapBufferARB, "glUnmapBufferARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetBufferParameterivARB, "glGetBufferParameterivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetBufferPointervARB, "glGetBufferPointervARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_occlusion_query()
		{
			if (!extIsSupported("GL_ARB_occlusion_query"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGenQueriesARB, "glGenQueriesARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteQueriesARB, "glDeleteQueriesARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsQueryARB, "glIsQueryARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBeginQueryARB, "glBeginQueryARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEndQueryARB, "glEndQueryARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetQueryivARB, "glGetQueryivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetQueryObjectivARB, "glGetQueryObjectivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetQueryObjectuivARB, "glGetQueryObjectuivARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_shader_objects()
		{
			if (!extIsSupported("GL_ARB_shader_objects"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDeleteObjectARB, "glDeleteObjectARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetHandleARB, "glGetHandleARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDetachObjectARB, "glDetachObjectARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCreateShaderObjectARB, "glCreateShaderObjectARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glShaderSourceARB, "glShaderSourceARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompileShaderARB, "glCompileShaderARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCreateProgramObjectARB, "glCreateProgramObjectARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glAttachObjectARB, "glAttachObjectARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glLinkProgramARB, "glLinkProgramARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUseProgramObjectARB, "glUseProgramObjectARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glValidateProgramARB, "glValidateProgramARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform1fARB, "glUniform1fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform2fARB, "glUniform2fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform3fARB, "glUniform3fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform4fARB, "glUniform4fARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform1iARB, "glUniform1iARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform2iARB, "glUniform2iARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform3iARB, "glUniform3iARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform4iARB, "glUniform4iARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform1fvARB, "glUniform1fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform2fvARB, "glUniform2fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform3fvARB, "glUniform3fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform4fvARB, "glUniform4fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform1ivARB, "glUniform1ivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform2ivARB, "glUniform2ivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform3ivARB, "glUniform3ivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform4ivARB, "glUniform4ivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniformMatrix2fvARB, "glUniformMatrix2fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniformMatrix3fvARB, "glUniformMatrix3fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniformMatrix4fvARB, "glUniformMatrix4fvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetObjectParameterfvARB, "glGetObjectParameterfvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetObjectParameterivARB, "glGetObjectParameterivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetInfoLogARB, "glGetInfoLogARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetAttachedObjectsARB, "glGetAttachedObjectsARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetUniformLocationARB, "glGetUniformLocationARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetActiveUniformARB, "glGetActiveUniformARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetUniformfvARB, "glGetUniformfvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetUniformivARB, "glGetUniformivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetShaderSourceARB, "glGetShaderSourceARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_vertex_shader()
		{
			if (!extIsSupported("GL_ARB_vertex_shader"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBindAttribLocationARB, "glBindAttribLocationARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetActiveAttribARB, "glGetActiveAttribARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetAttribLocationARB, "glGetAttribLocationARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_fragment_shader()
		{
			if (!extIsSupported("GL_ARB_fragment_shader"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_shading_language_100()
		{
			if (!extIsSupported("GL_ARB_shading_language_100"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_non_power_of_two()
		{
			if (!extIsSupported("GL_ARB_texture_non_power_of_two"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_point_sprite()
		{
			if (!extIsSupported("GL_ARB_point_sprite"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_fragment_program_shadow()
		{
			if (!extIsSupported("GL_ARB_fragment_program_shadow"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_draw_buffers()
		{
			if (!extIsSupported("GL_ARB_draw_buffers"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDrawBuffersARB, "glDrawBuffersARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_rectangle()
		{
			if (!extIsSupported("GL_ARB_texture_rectangle"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_color_buffer_float()
		{
			if (!extIsSupported("GL_ARB_color_buffer_float"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glClampColorARB, "glClampColorARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_half_float_pixel()
		{
			if (!extIsSupported("GL_ARB_half_float_pixel"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_float()
		{
			if (!extIsSupported("GL_ARB_texture_float"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_pixel_buffer_object()
		{
			if (!extIsSupported("GL_ARB_pixel_buffer_object"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_depth_buffer_float()
		{
			if (!extIsSupported("GL_ARB_depth_buffer_float"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_draw_instanced()
		{
			if (!extIsSupported("GL_ARB_draw_instanced"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDrawArraysInstancedARB, "glDrawArraysInstancedARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDrawElementsInstancedARB, "glDrawElementsInstancedARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_framebuffer_object()
		{
			if (!extIsSupported("GL_ARB_framebuffer_object"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glIsRenderbuffer, "glIsRenderbuffer"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindRenderbuffer, "glBindRenderbuffer"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteRenderbuffers, "glDeleteRenderbuffers"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenRenderbuffers, "glGenRenderbuffers"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glRenderbufferStorage, "glRenderbufferStorage"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glRenderbufferStorageMultisample, "glRenderbufferStorageMultisample"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetRenderbufferParameteriv, "glGetRenderbufferParameteriv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsFramebuffer, "glIsFramebuffer"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindFramebuffer, "glBindFramebuffer"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteFramebuffers, "glDeleteFramebuffers"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenFramebuffers, "glGenFramebuffers"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCheckFramebufferStatus, "glCheckFramebufferStatus"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferTexture1D, "glFramebufferTexture1D"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferTexture2D, "glFramebufferTexture2D"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferTexture3D, "glFramebufferTexture3D"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferTextureLayer, "glFramebufferTextureLayer"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferRenderbuffer, "glFramebufferRenderbuffer"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFramebufferAttachmentParameteriv, "glGetFramebufferAttachmentParameteriv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBlitFramebuffer, "glBlitFramebuffer"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenerateMipmap, "glGenerateMipmap"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_framebuffer_sRGB()
		{
			if (!extIsSupported("GL_ARB_framebuffer_sRGB"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_geometry_shader4()
		{
			if (!extIsSupported("GL_ARB_geometry_shader4"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glProgramParameteriARB, "glProgramParameteriARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferTextureARB, "glFramebufferTextureARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferTextureLayerARB, "glFramebufferTextureLayerARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferTextureFaceARB, "glFramebufferTextureFaceARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_half_float_vertex()
		{
			if (!extIsSupported("GL_ARB_half_float_vertex"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_imaging()
		{
			if (!extIsSupported("GL_ARB_imaging"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glColorTable, "glColorTable"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorSubTable, "glColorSubTable"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorTableParameteriv, "glColorTableParameteriv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorTableParameterfv, "glColorTableParameterfv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyColorSubTable, "glCopyColorSubTable"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyColorTable, "glCopyColorTable"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetColorTable, "glGetColorTable"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetColorTableParameterfv, "glGetColorTableParameterfv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetColorTableParameteriv, "glGetColorTableParameteriv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glHistogram, "glHistogram"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glResetHistogram, "glResetHistogram"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetHistogram, "glGetHistogram"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetHistogramParameterfv, "glGetHistogramParameterfv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetHistogramParameteriv, "glGetHistogramParameteriv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMinmax, "glMinmax"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glResetMinmax, "glResetMinmax"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMinmax, "glGetMinmax"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMinmaxParameterfv, "glGetMinmaxParameterfv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMinmaxParameteriv, "glGetMinmaxParameteriv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glConvolutionFilter1D, "glConvolutionFilter1D"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glConvolutionFilter2D, "glConvolutionFilter2D"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glConvolutionParameterf, "glConvolutionParameterf"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glConvolutionParameterfv, "glConvolutionParameterfv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glConvolutionParameteri, "glConvolutionParameteri"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glConvolutionParameteriv, "glConvolutionParameteriv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyConvolutionFilter1D, "glCopyConvolutionFilter1D"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyConvolutionFilter2D, "glCopyConvolutionFilter2D"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetConvolutionFilter, "glGetConvolutionFilter"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetConvolutionParameterfv, "glGetConvolutionParameterfv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetConvolutionParameteriv, "glGetConvolutionParameteriv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSeparableFilter2D, "glSeparableFilter2D"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetSeparableFilter, "glGetSeparableFilter"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_instanced_arrays()
		{
			if (!extIsSupported("GL_ARB_instanced_arrays"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glVertexAttribDivisorARB, "glVertexAttribDivisorARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_map_buffer_range()
		{
			if (!extIsSupported("GL_ARB_map_buffer_range"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glMapBufferRange, "glMapBufferRange"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFlushMappedBufferRange, "glFlushMappedBufferRange"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_buffer_object()
		{
			if (!extIsSupported("GL_ARB_texture_buffer_object"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTexBufferARB, "glTexBufferARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_compression_rgtc()
		{
			if (!extIsSupported("GL_ARB_texture_compression_rgtc"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_rg()
		{
			if (!extIsSupported("GL_ARB_texture_rg"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_vertex_array_object()
		{
			if (!extIsSupported("GL_ARB_vertex_array_object"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBindVertexArray, "glBindVertexArray"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteVertexArrays, "glDeleteVertexArrays"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenVertexArrays, "glGenVertexArrays"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsVertexArray, "glIsVertexArray"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_copy_buffer()
		{
			if (!extIsSupported("GL_ARB_copy_bffer"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glCopyBufferSubData, "glCopyBufferSubData"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_uniform_buffer_object()
		{
			if (!extIsSupported("GL_ARB_uniform_buffer_object"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGetUniformIndices, "glGetUniformIndices"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetActiveUniformsiv, "glGetActiveUniformsiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetActiveUniformName, "glGetActiveUniformName"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetUniformBlockIndex, "glGetUniformBlockIndex"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetActiveUniformBlockiv, "glGetActiveUniformBlockiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetActiveUniformBlockName, "glGetActiveUniformBlockName"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniformBlockBinding, "glUniformBlockBinding"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_vertex_array_bgra()
		{
			if (!extIsSupported("GL_ARB_vertex_array_bgra"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_draw_elements_base_vertex()
		{
			if (!extIsSupported("GL_ARB_uniform_buffer_object"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDrawElementsBaseVertex, "glDrawElementsBaseVertex"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDrawRangeElementsBaseVertex, "glDrawRangeElementsBaseVertex"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDrawElementsInstancedBaseVertex, "glDrawElementsInstancedBaseVertex"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiDrawElementsBaseVertex, "glMultiDrawElementsBaseVertex"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_vertex_attrib_64bit()
		{
			if (!extIsSupported("GL_ARB_vertex_attrib_64bit"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGetVertexAttribLdv, "glGetVertexAttribLdv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribL1d, "glVertexAttribL1d"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribL1dv, "glVertexAttribL1dv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribL2d, "glVertexAttribL2d"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribL2dv, "glVertexAttribL2dv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribL3d, "glVertexAttribL3d"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribL3dv, "glVertexAttribL3dv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribL4d, "glVertexAttribL4d"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribL4dv, "glVertexAttribL4dv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribLPointer, "glVertexAttribLPointer"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_provoking_vertex()
		{
			if (!extIsSupported("GL_ARB_provoking_vertex"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glProvokingVertex, "glProvokingVertex"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_sync()
		{
			if (!extIsSupported("GL_ARB_sync"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glFenceSync, "glFenceSync"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsSync, "glIsSync"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteSync, "glDeleteSync"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glClientWaitSync, "glClientWaitSync"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWaitSync, "glWaitSync"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetInteger64v, "glGetInteger64v"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetSynciv, "glGetSynciv"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_texture_multisample()
		{
			if (!extIsSupported("GL_ARB_texture_multisample"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTexImage2DMultisample, "glTexImage2DMultisample"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexImage3DMultisample, "glTexImage3DMultisample"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMultisamplefv, "glGetMultisamplefv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSampleMaski, "glSampleMaski"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_viewport_array()
		{
			if (!extIsSupported("GL_ARB_viewport_array"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDepthRangeArrayv, "glDepthRangeArrayv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDepthRangeIndexed, "glDepthRangeIndexed"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetDoublei_v, "glGetDoublei_v"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFloati_v, "glGetFloati_v"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glScissorArrayv, "glScissorArrayv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glScissorArrayIndexed, "glScissorArrayIndexed"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glScissorArrayIndexedv, "glScissorArrayIndexedv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glViewportArrayv, "glViewportArrayv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glViewportIndexedf, "glViewportIndexedf"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glViewportIndexedfv, "glViewportIndexedfv"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_cl_event()
		{
			if (!extIsSupported("GL_ARB_cl_event"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glCreateSyncFromCLeventARB, "glCreateSyncFromCLeventARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_debug_output()
		{
			if (!extIsSupported("GL_ARB_debug_output"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDebugMessageCallbackARB, "glDebugMessageCallbackARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDebugMessageControlARB, "glDebugMessageControlARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDebugMessageInsertARB, "glDebugMessageInsertARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetDebugMessageLogARB, "glGetDebugMessageLogARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_robustness()
		{
			if (!extIsSupported("GL_ARB_robustness"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGetnColorTableARB, "glGetnColorTableARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnCompressedTexImageARB, "glGetnCompressedTexImageARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnConvolutionFilterARB, "glGetnConvolutionFilterARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnHistogramARB, "glGetnHistogramARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnMapdvARB, "glGetnMapdvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnMapfvARB, "glGetnMapfvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnMapivARB, "glGetnMapivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnMinMaxARB, "glGetnMinMaxARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnPixelMapfvARB, "glGetnPixelMapfvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnPixelMapuivARB, "glGetnPixelMapuivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnPixelMapusvARB, "glGetnPixelMapusvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnPolygonStippleARB, "glGetnPolygonStippleARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnSeparableFilterARB, "glGetnSeparableFilterARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnTexImageARB, "glGetnTexImageARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnUniformdvARB, "glGetnUniformdvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnUniformfvARB, "glGetnUniformfvARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetnUniformivARB, "glGetnUniformivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetUniformuivARB, "glGetUniformuivARB"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReadnPixelsARB, "glReadnPixelsARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_shader_stencil_export()
		{
			if (!extIsSupported("GL_ARB_shader_stencil_export"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_compatibility()
		{
			if (!extIsSupported("GL_ARB_compatibility"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_depth_clamp()
		{
			if (!extIsSupported("GL_ARB_depth_clamp"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_blend_func_extended()
		{
			if (!extIsSupported("GL_ARB_blend_func_extended"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBindFragDataLocationIndexed, "glBindFragDataLocationIndexed"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFragDataIndex, "glGetFragDataIndex"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_sampler_objects()
		{
			if (!extIsSupported("GL_ARB_sampler_objects"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGenSamplers, "glGenSamplers"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteSamplers, "glDeleteSamplers"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsSampler, "glIsSampler"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindSampler, "glBindSampler"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSamplerParameteri, "glSamplerParameteri"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSamplerParameteriv, "glSamplerParameteriv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSamplerParameterf, "glSamplerParameterf"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSamplerParameterfv, "glSamplerParameterfv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSamplerParameterIiv, "glSamplerParameterIiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSamplerParameterIuiv, "glSamplerParameterIuiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetSamplerParameteriv, "glGetSamplerParameteriv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetSamplerParameterIiv, "glGetSamplerParameterIiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetSamplerParameterfv, "glGetSamplerParameterfv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetSamplerParameterIuiv, "glGetSamplerParameterIuiv"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_timer_query()
		{
			if (!extIsSupported("GL_ARB_timer_query"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glQueryCounter, "glQueryCounter"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetQueryObjecti64v, "glGetQueryObjecti64v"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetQueryObjectui64v, "glGetQueryObjectui64v"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ARB_vertex_type_2_10_10_10_rev()
		{
			if (!extIsSupported("GL_ARB_vertex_type_2_10_10_10_rev"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glVertexP2ui, "glVertexP2ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexP2uiv, "glVertexP2uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexP3ui, "glVertexP3ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexP3uiv, "glVertexP3uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexP4ui, "glVertexP4ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexP4uiv, "glVertexP4uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoordP1ui, "glTexCoordP1ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoordP1uiv, "glTexCoordP1uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoordP2ui, "glTexCoordP2ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoordP2uiv, "glTexCoordP2uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoordP3ui, "glTexCoordP3ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoordP3uiv, "glTexCoordP3uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoordP4ui, "glTexCoordP4ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoordP4uiv, "glTexCoordP4uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoordP1ui, "glMultiTexCoordP1ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoordP1uiv, "glMultiTexCoordP1uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoordP2ui, "glMultiTexCoordP2ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoordP2uiv, "glMultiTexCoordP2uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoordP3ui, "glMultiTexCoordP3ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoordP3uiv, "glMultiTexCoordP3uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoordP4ui, "glMultiTexCoordP4ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoordP4uiv, "glMultiTexCoordP4uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalP3ui, "glNormalP3ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalP3uiv, "glNormalP3uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorP3ui, "glColorP3ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorP3uiv, "glColorP3uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorP4ui, "glColorP4ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorP4uiv, "glColorP4uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColorP3ui, "glSecondaryColorP3ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColorP3uiv, "glSecondaryColorP3uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribP1ui, "glVertexAttribP1ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribP1uiv, "glVertexAttribP1uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribP2ui, "glVertexAttribP2ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribP2uiv, "glVertexAttribP2uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribP3ui, "glVertexAttribP3ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribP3uiv, "glVertexAttribP3uiv"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribP4ui, "glVertexAttribP4ui"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribP4uiv, "glVertexAttribP4uiv"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_EXT)
	{
		GLExtensionState load_GL_EXT_abgr()
		{
			if (!extIsSupported("GL_EXT_abgr"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_blend_color()
		{
			if (!extIsSupported("GL_EXT_blend_color"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBlendColorEXT, "glBlendColorEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_polygon_offset()
		{
			if (!extIsSupported("GL_EXT_polygon_offset"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glPolygonOffsetEXT, "glPolygonOffsetEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture()
		{
			if (!extIsSupported("GL_EXT_texture"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTexImage3DEXT, "glTexImage3DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexSubImage3DEXT, "glTexSubImage3DEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture3D()
		{
			if (!extIsSupported("GL_EXT_texture3D"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_subtexture()
		{
			if (!extIsSupported("GL_EXT_subtexture"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTexSubImage1DEXT, "glTexSubImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexSubImage21DEXT, "glTexSubImage21DEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_copy_texture()
		{
			if (!extIsSupported("GL_EXT_copy_texture"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glCopyTexImage1DEXT, "glCopyTexImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyTexImage2DEXT, "glCopyTexImage2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyTexSubImage1DEXT, "glCopyTexSubImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyTexSubImage2DEXT, "glCopyTexSubImage2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyTexSubImage3DEXT, "glCopyTexSubImage3DEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_histogram()
		{
			if (!extIsSupported("GL_EXT_histogram"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGetHistogramEXT, "glGetHistogramEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetHistogramParameterfvEXT, "glGetHistogramParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetHistogramParameterivEXT, "glGetHistogramParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMinmaxEXT, "glGetMinmaxEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMinmaxParameterfvEXT, "glGetMinmaxParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMinmaxParameterivEXT, "glGetMinmaxParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glHistogramEXT, "glHistogramEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMinmaxEXT, "glMinmaxEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glResetHistogramEXT, "glResetHistogramEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glResetMinmaxEXT, "glResetMinmaxEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_convolution()
		{
			if (!extIsSupported("GL_EXT_convolution"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glConvolutionFilter1DEXT, "glConvolutionFilter1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glConvolutionFilter2DEXT, "glConvolutionFilter2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glConvolutionParameterfEXT, "glConvolutionParameterfEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glConvolutionParameterfvEXT, "glConvolutionParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glConvolutionParameteriEXT, "glConvolutionParameteriEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glConvolutionParameterivEXT, "glConvolutionParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyConvolutionFilter1DEXT, "glCopyConvolutionFilter1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyConvolutionFilter2DEXT, "glCopyConvolutionFilter2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetConvolutionFilterEXT, "glGetConvolutionFilterEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetConvolutionParameterfvEXT, "glGetConvolutionParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetConvolutionParameterivEXT, "glGetConvolutionParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetSeparableFilterEXT, "glGetSeparableFilterEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSeparableFilter2DEXT, "glSeparableFilter2DEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_cmyka()
		{
			if (!extIsSupported("GL_EXT_cmyka"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_object()
		{
			if (!extIsSupported("GL_EXT_texture_object"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glAreTexturesResidentEXT, "glAreTexturesResidentEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindTextureEXT, "glBindTextureEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteTexturesEXT, "glDeleteTexturesEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenTexturesEXT, "glGenTexturesEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsTextureEXT, "glIsTextureEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPrioritizeTexturesEXT, "glPrioritizeTexturesEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_packed_pixels()
		{
			if (!extIsSupported("GL_EXT_packed_pixels"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_rescale_normal()
		{
			if (!extIsSupported("GL_EXT_rescale_normal"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_vertex_array()
		{
			if (!extIsSupported("GL_EXT_vertex_array"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glArrayElementEXT, "glArrayElementEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorPointerEXT, "glColorPointerEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDrawArraysEXT, "glDrawArraysEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEdgeFlagPointerEXT, "glEdgeFlagPointerEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetPointervEXT, "glGetPointervEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIndexPointerEXT, "glIndexPointerEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDrawArraysEXT, "glDrawArraysEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalPointerEXT, "glNormalPointerEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoordPointerEXT, "glTexCoordPointerEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexPointerEXT, "glVertexPointerEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_misc_attribute()
		{
			if (!extIsSupported("GL_EXT_misc_attribute"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_blend_minmax()
		{
			if (!extIsSupported("GL_EXT_blend_minmax"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBlendEquationEXT, "glBlendEquationEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_blend_subtract()
		{
			if (!extIsSupported("GL_EXT_blend_subtract"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_blend_logic_op()
		{
			if (!extIsSupported("GL_EXT_blend_logic_op"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_point_parameters()
		{
			if (!extIsSupported("GL_EXT_point_parameters"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glPointParameterfEXT, "glPointParameterfEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPointParameterfvEXT, "glPointParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_color_subtable()
		{
			if (!extIsSupported("GL_EXT_color_subtable"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glColorSubTableEXT, "glColorSubTableEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyColorSubTableEXT, "glCopyColorSubTableEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_paletted_texture()
		{
			if (!extIsSupported("GL_EXT_paletted_texture"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glColorTableEXT, "glColorTableEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetColorTableEXT, "glGetColorTableEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetColorTableParameterivEXT, "glGetColorTableParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetColorTableParameterfvEXT, "glGetColorTableParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_clip_volume_hint()
		{
			if (!extIsSupported("GL_EXT_clip_volume_hint"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_index_texture()
		{
			if (!extIsSupported("GL_EXT_index_texture"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_index_material()
		{
			if (!extIsSupported("GL_EXT_index_material"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glIndexMaterialEXT, "glIndexMaterialEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_index_func()
		{
			if (!extIsSupported("GL_EXT_index_func"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glIndexFuncEXT, "glIndexFuncEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_index_array_formats()
		{
			if (!extIsSupported("GL_EXT_index_array_formats"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_compiled_vertex_array()
		{
			if (!extIsSupported("GL_EXT_compiled_vertex_array"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glLockArraysEXT, "glLockArraysEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUnlockArraysEXT, "glUnlockArraysEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_cull_vertex()
		{
			if (!extIsSupported("GL_EXT_cull_vertex"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glCullParameterdvEXT, "glCullParameterdvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCullParameterfvEXT, "glCullParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_draw_range_elements()
		{
			if (!extIsSupported("GL_EXT_draw_range_elements"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDrawRangeElementsEXT, "glDrawRangeElementsEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_light_texture()
		{
			if (!extIsSupported("GL_EXT_light_texture"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glApplyTextureEXT, "glApplyTextureEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureLightEXT, "glTextureLightEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureMaterialEXT, "glTextureMaterialEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_bgra()
		{
			if (!extIsSupported("GL_EXT_bgra"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_pixel_transform()
		{
			if (!extIsSupported("GL_EXT_pixel_transform"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glPixelTransformParameteriEXT, "glPixelTransformParameteriEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPixelTransformParameterfEXT, "glPixelTransformParameterfEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPixelTransformParameterivEXT, "glPixelTransformParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPixelTransformParameterfvEXT, "glPixelTransformParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_pixel_transform_color_table()
		{
			if (!extIsSupported("GL_EXT_pixel_transform_color_table"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_shared_texture_palette()
		{
			if (!extIsSupported("GL_EXT_shared_texture_palette"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_separate_specular_color()
		{
			if (!extIsSupported("GL_EXT_separate_specular_color"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_secondary_color()
		{
			if (!extIsSupported("GL_EXT_secondary_color"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3bEXT, "glSecondaryColor3bEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3bvEXT, "glSecondaryColor3bvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3dEXT, "glSecondaryColor3dEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3dvEXT, "glSecondaryColor3dvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3fEXT, "glSecondaryColor3fEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3fvEXT, "glSecondaryColor3fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3iEXT, "glSecondaryColor3iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3ivEXT, "glSecondaryColor3ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3sEXT, "glSecondaryColor3sEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3svEXT, "glSecondaryColor3svEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3ubEXT, "glSecondaryColor3ubEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3ubvEXT, "glSecondaryColor3ubvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3uiEXT, "glSecondaryColor3uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3uivEXT, "glSecondaryColor3uivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3usEXT, "glSecondaryColor3usEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3usvEXT, "glSecondaryColor3usvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColorPointerEXT, "glSecondaryColorPointerEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_perturb_normal()
		{
			if (!extIsSupported("GL_EXT_texture_perturb_normal"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTextureNormalEXT, "glTextureNormalEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_multi_draw_arrays()
		{
			if (!extIsSupported("GL_EXT_multi_draw_arrays"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glMultiDrawArraysEXT, "glMultiDrawArraysEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiDrawElementsEXT, "glMultiDrawElementsEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_fog_coord()
		{
			if (!extIsSupported("GL_EXT_fog_coord"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glFogCoordfEXT, "glFogCoordfEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFogCoordfvEXT, "glFogCoordfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFogCoorddEXT, "glFogCoorddEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFogCoorddvEXT, "glFogCoorddvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFogCoordPointerEXT, "glFogCoordPointerEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_coordinate_frame()
		{
			if (!extIsSupported("GL_EXT_coordinate_frame"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTangent3bEXT, "glTangent3bEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTangent3bvEXT, "glTangent3bvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTangent3dEXT, "glTangent3dEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTangent3dvEXT, "glTangent3dvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTangent3fEXT, "glTangent3fEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTangent3fvEXT, "glTangent3fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTangent3iEXT, "glTangent3iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTangent3ivEXT, "glTangent3ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTangent3sEXT, "glTangent3sEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTangent3svEXT, "glTangent3svEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBinormal3bEXT, "glBinormal3bEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBinormal3bvEXT, "glBinormal3bvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBinormal3dEXT, "glBinormal3dEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBinormal3dvEXT, "glBinormal3dvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBinormal3fEXT, "glBinormal3fEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBinormal3fvEXT, "glBinormal3fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBinormal3iEXT, "glBinormal3iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBinormal3ivEXT, "glBinormal3ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBinormal3sEXT, "glBinormal3sEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBinormal3svEXT, "glBinormal3svEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTangentPointerEXT, "glTangentPointerEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBinormalPointerEXT, "glBinormalPointerEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_blend_func_separate()
		{
			if (!extIsSupported("GL_EXT_blend_func_separate"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBlendFuncSeparateEXT, "glBlendFuncSeparateEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_env_combine()
		{
			if (!extIsSupported("GL_EXT_texture_env_combine"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_stencil_wrap()
		{
			if (!extIsSupported("GL_EXT_stencil_wrap"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_422_pixels()
		{
			if (!extIsSupported("GL_EXT_422_pixels"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_cube_map()
		{
			if (!extIsSupported("GL_EXT_texture_cube_map"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_env_add()
		{
			if (!extIsSupported("GL_EXT_texture_env_add"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_lod_bias()
		{
			if (!extIsSupported("GL_EXT_texture_lod_bias"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_filter_anisotropic()
		{
			if (!extIsSupported("GL_EXT_texture_filter_anisotropic"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_vertex_weighting()
		{
			if (!extIsSupported("GL_EXT_vertex_weighting"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glVertexWeightfEXT, "glVertexWeightfEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexWeightfvEXT, "glVertexWeightfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexWeightPointerEXT, "glVertexWeightPointerEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_compression_s3tc()
		{
			if (!extIsSupported("GL_EXT_texture_compression_s3tc"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_multisample()
		{
			if (!extIsSupported("GL_EXT_multisample"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glSampleMaskEXT, "glSampleMaskEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSamplePatternEXT, "glSamplePatternEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_env_dot3()
		{
			if (!extIsSupported("GL_EXT_texture_env_dot3"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_vertex_shader()
		{
			if (!extIsSupported("GL_EXT_vertex_shader"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBeginVertexShaderEXT, "glBeginVertexShaderEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEndVertexShaderEXT, "glEndVertexShaderEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindVertexShaderEXT, "glBindVertexShaderEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenVertexShadersEXT, "glGenVertexShadersEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteVertexShaderEXT, "glDeleteVertexShaderEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glShaderOp1EXT, "glShaderOp1EXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glShaderOp2EXT, "glShaderOp2EXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glShaderOp3EXT, "glShaderOp3EXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSwizzleEXT, "glSwizzleEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWriteMaskEXT, "glWriteMaskEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glInsertComponentEXT, "glInsertComponentEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glExtractComponentEXT, "glExtractComponentEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenSymbolsEXT, "glGenSymbolsEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSetInvariantEXT, "glSetInvariantEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSetLocalConstantEXT, "glSetLocalConstantEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVariantbvEXT, "glVariantbvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVariantsvEXT, "glVariantsvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVariantivEXT, "glVariantivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVariantfvEXT, "glVariantfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVariantdvEXT, "glVariantdvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVariantubvEXT, "glVariantubvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVariantusvEXT, "glVariantusvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVariantuivEXT, "glVariantuivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVariantPointerEXT, "glVariantPointerEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEnableVariantClientStateEXT, "glEnableVariantClientStateEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDisableVariantClientStateEXT, "glDisableVariantClientStateEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindLightParameterEXT, "glBindLightParameterEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindMaterialParameterEXT, "glBindMaterialParameterEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindTexGenParameterEXT, "glBindTexGenParameterEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindTextureUnitParameterEXT, "glBindTextureUnitParameterEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindParameterEXT, "glBindParameterEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsVariantEnabledEXT, "glIsVariantEnabledEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVariantBooleanvEXT, "glGetVariantBooleanvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVariantIntegervEXT, "glGetVariantIntegervEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVariantFloatvEXT, "glGetVariantFloatvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVariantPointervEXT, "glGetVariantPointervEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetInvariantBooleanvEXT, "glGetInvariantBooleanvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetInvariantIntegervEXT, "glGetInvariantIntegervEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetInvariantFloatvEXT, "glGetInvariantFloatvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetLocalConstantBooleanvEXT, "glGetLocalConstantBooleanvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetLocalConstantIntegervEXT, "glGetLocalConstantIntegervEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetLocalConstantFloatvEXT, "glGetLocalConstantFloatvEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_shadow_funcs()
		{
			if (!extIsSupported("GL_EXT_shadow_funcs"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_stencil_two_side()
		{
			if (!extIsSupported("GL_EXT_stencil_two_side"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glActiveStencilFaceEXT, "glActiveStencilFaceEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_depth_bounds_test()
		{
			if (!extIsSupported("GL_EXT_depth_bounds_test"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDepthBoundsEXT, "glDepthBoundsEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_mirror_clamp()
		{
			if (!extIsSupported("GL_EXT_texture_mirror_clamp"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_blend_equation_separate()
		{
			if (!extIsSupported("GL_EXT_blend_equation_separate"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBlendEquationSeparateEXT, "glBlendEquationSeparateEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_pixel_buffer_object()
		{
			if (!extIsSupported("GL_EXT_pixel_buffer_object"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_framebuffer_object()
		{
			if (!extIsSupported("GL_EXT_framebuffer_object"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glIsRenderbufferEXT, "glIsRenderbufferEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindRenderbufferEXT, "glBindRenderbufferEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteRenderbuffersEXT, "glDeleteRenderbuffersEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenRenderbuffersEXT, "glGenRenderbuffersEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glRenderbufferStorageEXT, "glRenderbufferStorageEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetRenderbufferParameterivEXT, "glGetRenderbufferParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsFramebufferEXT, "glIsFramebufferEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindFramebufferEXT, "glBindFramebufferEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteFramebuffersEXT, "glDeleteFramebuffersEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenFramebuffersEXT, "glGenFramebuffersEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCheckFramebufferStatusEXT, "glCheckFramebufferStatusEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferTexture1DEXT, "glFramebufferTexture1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferTexture2DEXT, "glFramebufferTexture2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferTexture3DEXT, "glFramebufferTexture3DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferRenderbufferEXT, "glFramebufferRenderbufferEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFramebufferAttachmentParameterivEXT, "glGetFramebufferAttachmentParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenerateMipmapEXT, "glGenerateMipmapEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_packed_depth_stencil()
		{
			if (!extIsSupported("GL_EXT_packed_depth_stencil"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_stencil_clear_tag()
		{
			if (!extIsSupported("GL_EXT_stencil_clear_tag"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glStencilClearTagEXT, "glStencilClearTagEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_sRGB()
		{
			if (!extIsSupported("GL_EXT_texture_sRGB"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_framebuffer_blit()
		{
			if (!extIsSupported("GL_EXT_framebuffer_blit"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBlitFramebufferEXT, "glBlitFramebufferEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_framebuffer_multisample()
		{
			if (!extIsSupported("GL_EXT_framebuffer_multisample"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glRenderbufferStorageMultisampleEXT, "glRenderbufferStorageMultisampleEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_timer_query()
		{
			if (!extIsSupported("GL_EXT_timer_query"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGetQueryObjecti64vEXT, "glGetQueryObjecti64vEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetQueryObjectui64vEXT, "glGetQueryObjectui64vEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_gpu_program_parameters()
		{
			if (!extIsSupported("GL_EXT_gpu_program_parameters"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glProgramEnvParameters4fvEXT, "glProgramEnvParameters4fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramLocalParameters4fvEXT, "glProgramLocalParameters4fvEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_geometry_shader4()
		{
			if (!extIsSupported("GL_EXT_geometry_shader4"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glProgramParameteriEXT, "glProgramParameteriEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_gpu_shader4()
		{
			if (!extIsSupported("GL_EXT_gpu_shader4"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGetUniformuivEXT, "glGetUniformuivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindFragDataLocationEXT, "glBindFragDataLocationEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFragDataLocationEXT, "glGetFragDataLocationEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform1uiEXT, "glUniform1uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform2uiEXT, "glUniform2uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform3uiEXT, "glUniform3uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform4uiEXT, "glUniform4uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform1uivEXT, "glUniform1uivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform2uivEXT, "glUniform2uivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform3uivEXT, "glUniform3uivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniform4uivEXT, "glUniform4uivEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_draw_instanced()
		{
			if (!extIsSupported("GL_EXT_draw_instanced"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDrawArraysInstancedEXT, "glDrawArraysInstancedEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDrawElementsInstancedEXT, "glDrawElementsInstancedEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_packed_float()
		{
			if (!extIsSupported("GL_EXT_packed_float"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_array()
		{
			if (!extIsSupported("GL_EXT_texture_array"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_buffer_object()
		{
			if (!extIsSupported("GL_EXT_texture_buffer_object"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTexBufferEXT, "glTexBufferEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_compression_latc()
		{
			if (!extIsSupported("GL_EXT_texture_compression_latc"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_compression_rgtc()
		{
			if (!extIsSupported("GL_EXT_texture_compression_rgtc"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_shared_exponent()
		{
			if (!extIsSupported("GL_EXT_texture_shared_exponent"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_framebuffer_sRGB()
		{
			if (!extIsSupported("GL_EXT_framebuffer_sRGB"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_draw_buffers2()
		{
			if (!extIsSupported("GL_EXT_draw_buffers2"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glColorMaskIndexedEXT, "glColorMaskIndexedEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetBooleanIndexedvEXT, "glGetBooleanIndexedvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetIntegerIndexedvEXT, "glGetIntegerIndexedvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEnableIndexedEXT, "glEnableIndexedEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDisableIndexedEXT, "glDisableIndexedEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsEnabledIndexedEXT, "glIsEnabledIndexedEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_bindable_uniform()
		{
			if (!extIsSupported("GL_EXT_texture_buffer_object"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glUniformBufferEXT, "glUniformBufferEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetUniformBufferSizeEXT, "glGetUniformBufferSizeEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetUniformOffsetEXT, "glGetUniformOffsetEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_integer()
		{
			if (!extIsSupported("GL_EXT_texture_integer"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTexParameterIivEXT, "glTexParameterIivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexParameterIuivEXT, "glTexParameterIuivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTexParameterIivEXT, "glGetTexParameterIivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTexParameterIuivEXT, "glGetTexParameterIuivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glClearColorIiEXT, "glClearColorIiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glClearColorIuiEXT, "glClearColorIuiEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_transform_feedback()
		{
			if (!extIsSupported("GL_EXT_transform_feedback"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBeginTransformFeedbackEXT, "glBeginTransformFeedbackEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEndTransformFeedbackEXT, "glEndTransformFeedbackEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindBufferRangeEXT, "glBindBufferRangeEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindBufferOffsetEXT, "glBindBufferOffsetEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindBufferBaseEXT, "glBindBufferBaseEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTransformFeedbackVaryingsEXT, "glTransformFeedbackVaryingsEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTransformFeedbackVaryingEXT, "glGetTransformFeedbackVaryingEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_direct_state_access()
		{
			if (!extIsSupported("GL_EXT_direct_state_access"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glClientAttribDefaultEXT, "glClientAttribDefaultEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPushClientAttribDefaultEXT, "glPushClientAttribDefaultEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixLoadfEXT, "glMatrixLoadfEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixLoaddEXT, "glMatrixLoaddEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixMultfEXT, "glMatrixMultfEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixMultdEXT, "glMatrixMultdEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixLoadIdentityEXT, "glMatrixLoadIdentityEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixRotatefEXT, "glMatrixRotatefEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixRotatedEXT, "glMatrixRotatedEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixScalefEXT, "glMatrixScalefEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixScaledEXT, "glMatrixScaledEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixTranslatefEXT, "glMatrixTranslatefEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixTranslatedEXT, "glMatrixTranslatedEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixFrustumEXT, "glMatrixFrustumEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixOrthoEXT, "glMatrixOrthoEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixPopEXT, "glMatrixPopEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixPushEXT, "glMatrixPushEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixLoadTransposefEXT, "glMatrixLoadTransposefEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixLoadTransposedEXT, "glMatrixLoadTransposedEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixMultTransposefEXT, "glMatrixMultTransposefEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMatrixMultTransposedEXT, "glMatrixMultTransposedEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureParameterfEXT, "glTextureParameterfEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureParameterfvEXT, "glTextureParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureParameteriEXT, "glTextureParameteriEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureParameterivEXT, "glTextureParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureImage1DEXT, "glTextureImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureImage2DEXT, "glTextureImage2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureSubImage1DEXT, "glTextureSubImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureSubImage2DEXT, "glTextureSubImage2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyTextureImage1DEXT, "glCopyTextureImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyTextureImage2DEXT, "glCopyTextureImage2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyTextureSubImage1DEXT, "glCopyTextureSubImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyTextureSubImage2DEXT, "glCopyTextureSubImage2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTextureImageEXT, "glGetTextureImageEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTextureParameterfvEXT, "glGetTextureParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTextureParameterivEXT, "glGetTextureParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTextureLevelParameterfvEXT, "glGetTextureLevelParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTextureLevelParameterivEXT, "glGetTextureLevelParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureImage3DEXT, "glTextureImage3DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureSubImage3DEXT, "glTextureSubImage3DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyTextureSubImage3DEXT, "glCopyTextureSubImage3DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexParameterfEXT, "glMultiTexParameterfEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexParameterfvEXT, "glMultiTexParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexParameteriEXT, "glMultiTexParameteriEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexParameterivEXT, "glMultiTexParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexImage1DEXT, "glMultiTexImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexImage2DEXT, "glMultiTexImage2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexSubImage1DEXT, "glMultiTexSubImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexSubImage2DEXT, "glMultiTexSubImage2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyMultiTexImage1DEXT, "glCopyMultiTexImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyMultiTexImage2DEXT, "glCopyMultiTexImage2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyMultiTexSubImage1DEXT, "glCopyMultiTexSubImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyMultiTexSubImage2DEXT, "glCopyMultiTexSubImage2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMultiTexImageEXT, "glGetMultiTexImageEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMultiTexParameterfvEXT, "glGetMultiTexParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMultiTexParameterivEXT, "glGetMultiTexParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMultiTexLevelParameterfvEXT, "glGetMultiTexLevelParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMultiTexLevelParameterivEXT, "glGetMultiTexLevelParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexImage3DEXT, "glMultiTexImage3DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexSubImage3DEXT, "glMultiTexSubImage3DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyMultiTexSubImage3DEXT, "glCopyMultiTexSubImage3DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindMultiTextureEXT, "glBindMultiTextureEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEnableClientStateIndexedEXT, "glEnableClientStateIndexedEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDisableClientStateIndexedEXT, "glDisableClientStateIndexedEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoordPointerEXT, "glMultiTexCoordPointerEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexEnvfEXT, "glMultiTexEnvfEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexEnvfvEXT, "glMultiTexEnvfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexEnviEXT, "glMultiTexEnviEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexEnvivEXT, "glMultiTexEnvivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexGendEXT, "glMultiTexGendEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexGendvEXT, "glMultiTexGendvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexGenfEXT, "glMultiTexGenfEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexGenfvEXT, "glMultiTexGenfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexGeniEXT, "glMultiTexGeniEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexGenivEXT, "glMultiTexGenivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMultiTexEnvfvEXT, "glGetMultiTexEnvfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMultiTexEnvivEXT, "glGetMultiTexEnvivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMultiTexGendvEXT, "glGetMultiTexGendvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMultiTexGenfvEXT, "glGetMultiTexGenfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMultiTexGenivEXT, "glGetMultiTexGenivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFloatIndexedvEXT, "glGetFloatIndexedvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetDoubleIndexedvEXT, "glGetDoubleIndexedvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetPointerIndexedvEXT, "glGetPointerIndexedvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedTextureImage3DEXT, "glCompressedTextureImage3DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedTextureImage2DEXT, "glCompressedTextureImage2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedTextureImage1DEXT, "glCompressedTextureImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedTextureSubImage3DEXT, "glCompressedTextureSubImage3DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedTextureSubImage2DEXT, "glCompressedTextureSubImage2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedTextureSubImage1DEXT, "glCompressedTextureSubImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetCompressedTextureImageEXT, "glGetCompressedTextureImageEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedMultiTexImage3DEXT, "glCompressedMultiTexImage3DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedMultiTexImage2DEXT, "glCompressedMultiTexImage2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedMultiTexImage1DEXT, "glCompressedMultiTexImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedMultiTexSubImage3DEXT, "glCompressedMultiTexSubImage3DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedMultiTexSubImage2DEXT, "glCompressedMultiTexSubImage2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCompressedMultiTexSubImage1DEXT, "glCompressedMultiTexSubImage1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetCompressedMultiTexImageEXT, "glGetCompressedMultiTexImageEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedProgramStringEXT, "glNamedProgramStringEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedProgramLocalParameter4dEXT, "glNamedProgramLocalParameter4dEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedProgramLocalParameter4dvEXT, "glNamedProgramLocalParameter4dvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedProgramLocalParameter4fEXT, "glNamedProgramLocalParameter4fEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedProgramLocalParameter4fvEXT, "glNamedProgramLocalParameter4fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetNamedProgramLocalParameterdvEXT, "glGetNamedProgramLocalParameterdvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetNamedProgramLocalParameterfvEXT, "glGetNamedProgramLocalParameterfvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetNamedProgramivEXT, "glGetNamedProgramivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetNamedProgramStringEXT, "glGetNamedProgramStringEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedProgramLocalParameters4fvEXT, "glNamedProgramLocalParameters4fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedProgramLocalParameterI4iEXT, "glNamedProgramLocalParameterI4iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedProgramLocalParameterI4ivEXT, "glNamedProgramLocalParameterI4ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedProgramLocalParametersI4ivEXT, "glNamedProgramLocalParametersI4ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedProgramLocalParameterI4uiEXT, "glNamedProgramLocalParameterI4uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedProgramLocalParameterI4uivEXT, "glNamedProgramLocalParameterI4uivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedProgramLocalParametersI4uivEXT, "glNamedProgramLocalParametersI4uivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetNamedProgramLocalParameterIivEXT, "glGetNamedProgramLocalParameterIivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetNamedProgramLocalParameterIuivEXT, "glGetNamedProgramLocalParameterIuivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureParameterIivEXT, "glTextureParameterIivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureParameterIuivEXT, "glTextureParameterIuivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTextureParameterIivEXT, "glGetTextureParameterIivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTextureParameterIuivEXT, "glGetTextureParameterIuivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexParameterIivEXT, "glMultiTexParameterIivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexParameterIuivEXT, "glMultiTexParameterIuivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMultiTexParameterIivEXT, "glGetMultiTexParameterIivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMultiTexParameterIuivEXT, "glGetMultiTexParameterIuivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform1fEXT, "glProgramUniform1fEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform2fEXT, "glProgramUniform2fEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform3fEXT, "glProgramUniform3fEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform4fEXT, "glProgramUniform4fEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform1iEXT, "glProgramUniform1iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform2iEXT, "glProgramUniform2iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform3iEXT, "glProgramUniform3iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform4iEXT, "glProgramUniform4iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform1fvEXT, "glProgramUniform1fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform2fvEXT, "glProgramUniform2fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform3fvEXT, "glProgramUniform3fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform4fvEXT, "glProgramUniform4fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform1ivEXT, "glProgramUniform1ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform2ivEXT, "glProgramUniform2ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform3ivEXT, "glProgramUniform3ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform4ivEXT, "glProgramUniform4ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix2fvEXT, "glProgramUniformMatrix2fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix3fvEXT, "glProgramUniformMatrix3fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix4fvEXT, "glProgramUniformMatrix4fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix2x3fvEXT, "glProgramUniformMatrix2x3fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix3x2fvEXT, "glProgramUniformMatrix3x2fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix2x4fvEXT, "glProgramUniformMatrix2x4fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix4x2fvEXT, "glProgramUniformMatrix4x2fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix3x4fvEXT, "glProgramUniformMatrix3x4fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix4x3fvEXT, "glProgramUniformMatrix4x3fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform1uiEXT, "glProgramUniform1uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform2uiEXT, "glProgramUniform2uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMultiTexParameterIuivEXT, "glGetMultiTexParameterIuivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform1fEXT, "glProgramUniform1fEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform2fEXT, "glProgramUniform2fEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform3fEXT, "glProgramUniform3fEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform4fEXT, "glProgramUniform4fEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform1iEXT, "glProgramUniform1iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform2iEXT, "glProgramUniform2iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform3iEXT, "glProgramUniform3iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform4iEXT, "glProgramUniform4iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform1fvEXT, "glProgramUniform1fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform2fvEXT, "glProgramUniform2fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform3fvEXT, "glProgramUniform3fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform4fvEXT, "glProgramUniform4fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform1ivEXT, "glProgramUniform1ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform2ivEXT, "glProgramUniform2ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform3ivEXT, "glProgramUniform3ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform4ivEXT, "glProgramUniform4ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix2fvEXT, "glProgramUniformMatrix2fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix3fvEXT, "glProgramUniformMatrix3fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix4fvEXT, "glProgramUniformMatrix4fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix2x3fvEXT, "glProgramUniformMatrix2x3fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix3x2fvEXT, "glProgramUniformMatrix3x2fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix2x4fvEXT, "glProgramUniformMatrix2x4fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix4x2fvEXT, "glProgramUniformMatrix4x2fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix3x4fvEXT, "glProgramUniformMatrix3x4fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformMatrix4x3fvEXT, "glProgramUniformMatrix4x3fvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform1uiEXT, "glProgramUniform1uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform2uiEXT, "glProgramUniform2uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform3uiEXT, "glProgramUniform3uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform4uiEXT, "glProgramUniform4uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform1uivEXT, "glProgramUniform1uivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform2uivEXT, "glProgramUniform2uivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform3uivEXT, "glProgramUniform3uivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniform4uivEXT, "glProgramUniform4uivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedBufferDataEXT, "glNamedBufferDataEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedBufferSubDataEXT, "glNamedBufferSubDataEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMapNamedBufferEXT, "glMapNamedBufferEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUnmapNamedBufferEXT, "glUnmapNamedBufferEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetNamedBufferParameterivEXT, "glGetNamedBufferParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetNamedBufferPointervEXT, "glGetNamedBufferPointervEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetNamedBufferSubDataEXT, "glGetNamedBufferSubDataEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureBufferEXT, "glTextureBufferEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexBufferEXT, "glMultiTexBufferEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedRenderbufferStorageEXT, "glNamedRenderbufferStorageEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetNamedRenderbufferParameterivEXT, "glGetNamedRenderbufferParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCheckNamedFramebufferStatusEXT, "glCheckNamedFramebufferStatusEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedFramebufferTexture1DEXT, "glNamedFramebufferTexture1DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedFramebufferTexture2DEXT, "glNamedFramebufferTexture2DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedFramebufferTexture3DEXT, "glNamedFramebufferTexture3DEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedFramebufferRenderbufferEXT, "glNamedFramebufferRenderbufferEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetNamedFramebufferAttachmentParameterivEXT, "glGetNamedFramebufferAttachmentParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenerateTextureMipmapEXT, "glGenerateTextureMipmapEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenerateMultiTexMipmapEXT, "glGenerateMultiTexMipmapEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferDrawBufferEXT, "glFramebufferDrawBufferEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferDrawBuffersEXT, "glFramebufferDrawBuffersEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferReadBufferEXT, "glFramebufferReadBufferEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFramebufferParameterivEXT, "glGetFramebufferParameterivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedRenderbufferStorageMultisampleEXT, "glNamedRenderbufferStorageMultisampleEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedRenderbufferStorageMultisampleCoverageEXT, "glNamedRenderbufferStorageMultisampleCoverageEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedFramebufferTextureEXT, "glNamedFramebufferTextureEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedFramebufferTextureLayerEXT, "glNamedFramebufferTextureLayerEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedFramebufferTextureFaceEXT, "glNamedFramebufferTextureFaceEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTextureRenderbufferEXT, "glTextureRenderbufferEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexRenderbufferEXT, "glMultiTexRenderbufferEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_vertex_array_bgra()
		{
			if (!extIsSupported("GL_EXT_vertex_array_bgra"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_swizzle()
		{
			if (!extIsSupported("GL_EXT_texture_swizzle"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_provoking_vertex()
		{
			if (!extIsSupported("GL_EXT_provoking_vertex"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glProvokingVertexEXT, "glProvokingVertexEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_texture_snorm()
		{
			if (!extIsSupported("GL_EXT_texture_snorm"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_EXT_separate_shader_objects()
		{
			if (!extIsSupported("GL_EXT_separate_shader_objects"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glUseShaderProgramEXT, "glUseShaderProgramEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glActiveProgramEXT, "glActiveProgramEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCreateShaderProgramEXT, "glCreateShaderProgramEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_NV)
	{
		GLExtensionState load_GL_NV_texgen_reflection()
		{
			if (!extIsSupported("GL_NV_texgen_reflection"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_light_max_exponent()
		{
			if (!extIsSupported("GL_NV_light_max_exponent"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_vertex_array_range()
		{
			if (!extIsSupported("GL_NV_vertex_array_range"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glFlushVertexArrayRangeNV, "glFlushVertexArrayRangeNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexArrayRangeNV, "glVertexArrayRangeNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_register_combiners()
		{
			if (!extIsSupported("GL_NV_register_combiners"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glCombinerParameterfvNV, "glCombinerParameterfvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCombinerParameterfNV, "glCombinerParameterfNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCombinerParameterivNV, "glCombinerParameterivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCombinerParameteriNV, "glCombinerParameteriNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCombinerInputNV, "glCombinerInputNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCombinerOutputNV, "glCombinerOutputNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFinalCombinerInputNV, "glFinalCombinerInputNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetCombinerInputParameterfvNV, "glGetCombinerInputParameterfvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetCombinerInputParameterivNV, "glGetCombinerInputParameterivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetCombinerOutputParameterfvNV, "glGetCombinerOutputParameterfvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetCombinerOutputParameterivNV, "glGetCombinerOutputParameterivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFinalCombinerInputParameterfvNV, "glGetFinalCombinerInputParameterfvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFinalCombinerInputParameterivNV, "glGetFinalCombinerInputParameterivNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_fog_distance()
		{
			if (!extIsSupported("GL_NV_fog_distance"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_texgen_emboss()
		{
			if (!extIsSupported("GL_NV_texgen_emboss"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_blend_square()
		{
			if (!extIsSupported("GL_NV_blend_square"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_texture_env_combine4()
		{
			if (!extIsSupported("GL_NV_texture_env_combine4"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_fence()
		{
			if (!extIsSupported("GL_NV_fence"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDeleteFencesNV, "glDeleteFencesNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenFencesNV, "glGenFencesNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsFenceNV, "glIsFenceNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTestFenceNV, "glTestFenceNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFenceivNV, "glGetFenceivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFinishFenceNV, "glFinishFenceNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSetFenceNV, "glSetFenceNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_evaluators()
		{
			if (!extIsSupported("GL_NV_evaluators"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glMapControlPointsNV, "glMapControlPointsNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMapParameterivNV, "glMapParameterivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMapParameterfvNV, "glMapParameterfvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMapControlPointsNV, "glGetMapControlPointsNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMapParameterivNV, "glGetMapParameterivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMapParameterfvNV, "glGetMapParameterfvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMapAttribParameterivNV, "glGetMapAttribParameterivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetMapAttribParameterfvNV, "glGetMapAttribParameterfvNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_packed_depth_stencil()
		{
			if (!extIsSupported("GL_NV_packed_depth_stencil"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_register_combiners2()
		{
			if (!extIsSupported("GL_NV_register_combiners2"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glCombinerStageParameterfvNV, "glCombinerStageParameterfvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetCombinerStageParameterfvNV, "glGetCombinerStageParameterfvNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_texture_compression_vtc()
		{
			if (!extIsSupported("GL_NV_texture_compression_vtc"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_texture_rectangle()
		{
			if (!extIsSupported("GL_NV_texture_shader"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_texture_shader()
		{
			if (!extIsSupported("GL_NV_texture_shader"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_texture_shader2()
		{
			if (!extIsSupported("GL_NV_texture_shader2"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_vertex_array_range2()
		{
			if (!extIsSupported("GL_NV_vertex_array_range2"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_vertex_program()
		{
			if (!extIsSupported("GL_NV_vertex_program"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glAreProgramsResidentNV, "glAreProgramsResidentNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindProgramNV, "glBindProgramNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteProgramsNV, "glDeleteProgramsNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glExecuteProgramNV, "glExecuteProgramNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenProgramsNV, "glGenProgramsNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramParameterdvNV, "glGetProgramParameterdvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramParameterfvNV, "glGetProgramParameterfvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramivNV, "glGetProgramivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramStringNV, "glGetProgramStringNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTrackMatrixivNV, "glGetTrackMatrixivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVertexAttribdvNV, "glGetVertexAttribdvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVertexAttribfvNV, "glGetVertexAttribfvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVertexAttribivNV, "glGetVertexAttribivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVertexAttribPointervNV, "glGetVertexAttribPointervNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsProgramNV, "glIsProgramNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glLoadProgramNV, "glLoadProgramNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramParameter4dNV, "glProgramParameter4dNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramParameter4dvNV, "glProgramParameter4dvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramParameter4fNV, "glProgramParameter4fNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramParameter4fvNV, "glProgramParameter4fvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramParameters4dvNV, "glProgramParameters4dvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramParameters4fvNV, "glProgramParameters4fvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glRequestResidentProgramsNV, "glRequestResidentProgramsNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTrackMatrixNV, "glTrackMatrixNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribPointerNV, "glVertexAttribPointerNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib1dNV, "glVertexAttrib1dNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib1dvNV, "glVertexAttrib1dvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib1fNV, "glVertexAttrib1fNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib1fvNV, "glVertexAttrib1fvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib1sNV, "glVertexAttrib1sNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib1svNV, "glVertexAttrib1svNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib2dNV, "glVertexAttrib2dNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib2dvNV, "glVertexAttrib2dvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib2fNV, "glVertexAttrib2fNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib2fvNV, "glVertexAttrib2fvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib2sNV, "glVertexAttrib2sNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib2svNV, "glVertexAttrib2svNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib3dNV, "glVertexAttrib3dNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib3dvNV, "glVertexAttrib3dvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib3fNV, "glVertexAttrib3fNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib3fvNV, "glVertexAttrib3fvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib3sNV, "glVertexAttrib3sNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib3svNV, "glVertexAttrib3svNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4dNV, "glVertexAttrib4dNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4dvNV, "glVertexAttrib4dvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4fNV, "glVertexAttrib4fNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4fvNV, "glVertexAttrib4fvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4sNV, "glVertexAttrib4sNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4svNV, "glVertexAttrib4svNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4ubNV, "glVertexAttrib4ubNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4ubvNV, "glVertexAttrib4ubvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs1dvNV, "glVertexAttribs1dvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs1fvNV, "glVertexAttribs1fvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs1svNV, "glVertexAttribs1svNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs2dvNV, "glVertexAttribs2dvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs2fvNV, "glVertexAttribs2fvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs2svNV, "glVertexAttribs2svNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs3dvNV, "glVertexAttribs3dvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs3fvNV, "glVertexAttribs3fvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs3svNV, "glVertexAttribs3svNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs4dvNV, "glVertexAttribs4dvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs4fvNV, "glVertexAttribs4fvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs4svNV, "glVertexAttribs4svNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs4ubvNV, "glVertexAttribs4ubvNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_copy_depth_to_color()
		{
			if (!extIsSupported("GL_NV_copy_depth_to_color"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_multisample_filter_hint()
		{
			if (!extIsSupported("GL_NV_multisample_filter_hint"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_depth_clamp()
		{
			if (!extIsSupported("GL_NV_depth_clamp"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_occlusion_query()
		{
			if (!extIsSupported("GL_NV_occlusion_query"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGenOcclusionQueriesNV, "glGenOcclusionQueriesNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteOcclusionQueriesNV, "glDeleteOcclusionQueriesNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsOcclusionQueryNV, "glIsOcclusionQueryNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBeginOcclusionQueryNV, "glBeginOcclusionQueryNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEndOcclusionQueryNV, "glEndOcclusionQueryNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetOcclusionQueryivNV, "glGetOcclusionQueryivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetOcclusionQueryuivNV, "glGetOcclusionQueryuivNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_point_sprite()
		{
			if (!extIsSupported("GL_NV_point_sprite"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glPointParameteriNV, "glPointParameteriNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPointParameterivNV, "glPointParameterivNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_texture_shader3()
		{
			if (!extIsSupported("GL_NV_texture_shader3"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_vertex_program1_1()
		{
			if (!extIsSupported("GL_NV_vertex_program1_1"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_float_buffer()
		{
			if (!extIsSupported("GL_NV_float_buffer"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_fragment_program()
		{
			if (!extIsSupported("GL_NV_fragment_program"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glProgramNamedParameter4fNV, "glProgramNamedParameter4fNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramNamedParameter4dNV, "glProgramNamedParameter4dNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramNamedParameter4fvNV, "glProgramNamedParameter4fvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramNamedParameter4dvNV, "glProgramNamedParameter4dvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramNamedParameterfvNV, "glGetProgramNamedParameterfvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramNamedParameterdvNV, "glGetProgramNamedParameterdvNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_half_float()
		{
			if (!extIsSupported("GL_NV_half_float"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glVertex2hNV, "glVertex2hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertex2hvNV, "glVertex2hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertex3hNV, "glVertex3hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertex3hvNV, "glVertex3hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertex4hNV, "glVertex4hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertex4hvNV, "glVertex4hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormal3hNV, "glNormal3hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormal3hvNV, "glNormal3hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColor3hNV, "glColor3hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColor3hvNV, "glColor3hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColor4hNV, "glColor4hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColor4hvNV, "glColor4hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord1hNV, "glTexCoord1hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord1hvNV, "glTexCoord1hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord2hNV, "glTexCoord2hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord2hvNV, "glTexCoord2hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord3hNV, "glTexCoord3hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord3hvNV, "glTexCoord3hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord4hNV, "glTexCoord4hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord4hvNV, "glTexCoord4hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord1hNV, "glMultiTexCoord1hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord1hvNV, "glMultiTexCoord1hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord2hNV, "glMultiTexCoord2hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord2hvNV, "glMultiTexCoord2hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord3hNV, "glMultiTexCoord3hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord3hvNV, "glMultiTexCoord3hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord4hNV, "glMultiTexCoord4hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiTexCoord4hvNV, "glMultiTexCoord4hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFogCoordhNV, "glFogCoordhNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFogCoordhvNV, "glFogCoordhvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3hNV, "glSecondaryColor3hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColor3hvNV, "glSecondaryColor3hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib1hNV, "glVertexAttrib1hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib1hvNV, "glVertexAttrib1hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib2hNV, "glVertexAttrib2hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib2hvNV, "glVertexAttrib2hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib3hNV, "glVertexAttrib3hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib3hvNV, "glVertexAttrib3hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4hNV, "glVertexAttrib4hNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttrib4hvNV, "glVertexAttrib4hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs1hvNV, "glVertexAttribs1hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs2hvNV, "glVertexAttribs2hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs3hvNV, "glVertexAttribs3hvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribs4hvNV, "glVertexAttribs4hvNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_pixel_data_range()
		{
			if (!extIsSupported("GL_NV_pixel_data_range"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glPixelDataRangeNV, "glPixelDataRangeNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFlushPixelDataRangeNV, "glFlushPixelDataRangeNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_primitive_restart()
		{
			if (!extIsSupported("GL_NV_primitive_restart"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glPrimitiveRestartNV, "glPrimitiveRestartNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPrimitiveRestartIndexNV, "glPrimitiveRestartIndexNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_texture_expand_normal()
		{
			if (!extIsSupported("GL_NV_texture_expand_normal"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_vertex_program2()
		{
			if (!extIsSupported("GL_NV_vertex_program2"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_fragment_program_option()
		{
			if (!extIsSupported("GL_NV_fragment_program_option"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_fragment_program2()
		{
			if (!extIsSupported("GL_NV_fragment_program2"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_vertex_program2_option()
		{
			if (!extIsSupported("GL_NV_vertex_program2_option"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_vertex_program3()
		{
			if (!extIsSupported("GL_NV_vertex_program3"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_gpu_program4()
		{
			if (!extIsSupported("GL_NV_gpu_program4"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glProgramLocalParameterI4iNV, "glProgramLocalParameterI4iNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramLocalParameterI4ivNV, "glProgramLocalParameterI4ivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramLocalParametersI4ivNV, "glProgramLocalParametersI4ivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramLocalParameterI4uiNV, "glProgramLocalParameterI4uiNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramLocalParameterI4uivNV, "glProgramLocalParameterI4uivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramLocalParametersI4uivNV, "glProgramLocalParametersI4uivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramEnvParameterI4iNV, "glProgramEnvParameterI4iNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramEnvParameterI4ivNV, "glProgramEnvParameterI4ivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramEnvParametersI4ivNV, "glProgramEnvParametersI4ivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramEnvParameterI4uiNV, "glProgramEnvParameterI4uiNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramEnvParameterI4uivNV, "glProgramEnvParameterI4uivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramEnvParametersI4uivNV, "glProgramEnvParametersI4uivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramLocalParameterIivNV, "glGetProgramLocalParameterIivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramLocalParameterIuivNV, "glGetProgramLocalParameterIuivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramEnvParameterIivNV, "glGetProgramEnvParameterIivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetProgramEnvParameterIuivNV, "glGetProgramEnvParameterIuivNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_geometry_program4()
		{
			if (!extIsSupported("GL_NV_geometry_program4"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glProgramVertexLimitNV, "glProgramVertexLimitNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferTextureEXT, "glFramebufferTextureEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferTextureLayerEXT, "glFramebufferTextureLayerEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFramebufferTextureFaceEXT, "glFramebufferTextureFaceEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_vertex_program4()
		{
			if (!extIsSupported("GL_NV_vertex_program4"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glVertexAttribI1iEXT, "glVertexAttribI1iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI2iEXT, "glVertexAttribI2iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI3iEXT, "glVertexAttribI3iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI4iEXT, "glVertexAttribI4iEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI1uiEXT, "glVertexAttribI1uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI2uiEXT, "glVertexAttribI2uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI3uiEXT, "glVertexAttribI3uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI4uiEXT, "glVertexAttribI4uiEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI1ivEXT, "glVertexAttribI1ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI2ivEXT, "glVertexAttribI2ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI3ivEXT, "glVertexAttribI3ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI4ivEXT, "glVertexAttribI4ivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI1uivEXT, "glVertexAttribI1uivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI2uivEXT, "glVertexAttribI2uivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI3uivEXT, "glVertexAttribI3uivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI4uivEXT, "glVertexAttribI4uivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI4bvEXT, "glVertexAttribI4bvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI4svEXT, "glVertexAttribI4svEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI4ubvEXT, "glVertexAttribI4ubvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribI4usvEXT, "glVertexAttribI4usvEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribIPointerEXT, "glVertexAttribIPointerEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVertexAttribIivEXT, "glGetVertexAttribIivEXT"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVertexAttribIuivEXT, "glGetVertexAttribIuivEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_depth_buffer_float()
		{
			if (!extIsSupported("GL_NV_depth_buffer_float"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDepthRangedNV, "glDepthRangedNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glClearDepthdNV, "glClearDepthdNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDepthBoundsdNV, "glDepthBoundsdNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_fragment_program4()
		{
			if (!extIsSupported("GL_NV_fragment_program4"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_framebuffer_multisample_coverage()
		{
			if (!extIsSupported("GL_NV_framebuffer_multisample_coverage"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glRenderbufferStorageMultisampleCoverageNV, "glRenderbufferStorageMultisampleCoverageNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_geometry_shader4()
		{
			if (!extIsSupported("GL_NV_geometry_shader4"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_transform_feedback()
		{
			if (!extIsSupported("GL_NV_transform_feedback"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBeginTransformFeedbackNV, "glBeginTransformFeedbackNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEndTransformFeedbackNV, "glEndTransformFeedbackNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTransformFeedbackAttribsNV, "glTransformFeedbackAttribsNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindBufferRangeNV, "glBindBufferRangeNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindBufferOffsetNV, "glBindBufferOffsetNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindBufferBaseNV, "glBindBufferBaseNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTransformFeedbackVaryingsNV, "glTransformFeedbackVaryingsNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glActiveVaryingNV, "glActiveVaryingNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVaryingLocationNV, "glGetVaryingLocationNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetActiveVaryingNV, "glGetActiveVaryingNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTransformFeedbackVaryingNV, "glGetTransformFeedbackVaryingNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_conditional_render()
		{
			if (!extIsSupported("GL_NV_conditional_render"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBeginConditionalRenderNV, "glBeginConditionalRenderNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEndConditionalRenderNV, "glEndConditionalRenderNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_present_video()
		{
			if (!extIsSupported("GL_NV_present_video"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glPresentFrameKeyedNV, "glPresentFrameKeyedNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPresentFrameDualFillNV, "glPresentFrameDualFillNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVideoivNV, "glGetVideoivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVideouivNV, "glGetVideouivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVideoi64vNV, "glGetVideoi64vNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVideoui64vNV, "glGetVideoui64vNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_explicit_multisample()
		{
			if (!extIsSupported("GL_NV_explicit_multisample"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGetMultisamplefvNV, "glGetMultisamplefvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSampleMaskIndexedNV, "glSampleMaskIndexedNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexRenderbufferNV, "glTexRenderbufferNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_transform_feedback2()
		{
			if (!extIsSupported("GL_NV_transform_feedback2"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBindTransformFeedbackNV, "glBindTransformFeedbackNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteTransformFeedbacksNV, "glDeleteTransformFeedbacksNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenTransformFeedbacksNV, "glGenTransformFeedbacksNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsTransformFeedbackNV, "glIsTransformFeedbackNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPauseTransformFeedbackNV, "glPauseTransformFeedbackNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glResumeTransformFeedbackNV, "glResumeTransformFeedbackNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDrawTransformFeedbackNV, "glDrawTransformFeedbackNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_video_capture()
		{
			if (!extIsSupported("GL_NV_video_capture"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBeginVideoCaptureNV, "glBeginVideoCaptureNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindVideoCaptureStreamBufferNV, "glBindVideoCaptureStreamBufferNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindVideoCaptureStreamTextureNV, "glBindVideoCaptureStreamTextureNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEndVideoCaptureNV, "glEndVideoCaptureNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVideoCaptureivNV, "glGetVideoCaptureivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVideoCaptureStreamivNV, "glGetVideoCaptureStreamivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVideoCaptureStreamfvNV, "glGetVideoCaptureStreamfvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVideoCaptureStreamdvNV, "glGetVideoCaptureStreamdvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVideoCaptureNV, "glVideoCaptureNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVideoCaptureStreamParameterivNV, "glVideoCaptureStreamParameterivNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVideoCaptureStreamParameterfvNV, "glVideoCaptureStreamParameterfvNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVideoCaptureStreamParameterdvNV, "glVideoCaptureStreamParameterdvNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_copy_image()
		{
			if (!extIsSupported("GL_NV_copy_image"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glCopyImageSubDataNV, "glCopyImageSubDataNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_parameter_buffer_object2()
		{
			if (!extIsSupported("GL_NV_parameter_buffer_object2"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_shader_buffer_load()
		{
			if (!extIsSupported("GL_NV_shader_buffer_load"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glMakeBufferResidentNV, "glMakeBufferResidentNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMakeBufferNonResidentNV, "glMakeBufferNonResidentNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsBufferResidentNV, "glIsBufferResidentNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedMakeBufferResidentNV, "glNamedMakeBufferResidentNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNamedMakeBufferNonResidentNV, "glNamedMakeBufferNonResidentNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsNamedBufferResidentNV, "glIsNamedBufferResidentNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetBufferParameterui64vNV, "glGetBufferParameterui64vNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetNamedBufferParameterui64vNV, "glGetNamedBufferParameterui64vNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetIntegerui64vNV, "glGetIntegerui64vNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniformui64NV, "glUniformui64NV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUniformui64vNV, "glUniformui64vNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetUniformui64vNV, "glGetUniformui64vNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformui64NV, "glProgramUniformui64NV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glProgramUniformui64vNV, "glProgramUniformui64vNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_vertex_buffer_unified_memory()
		{
			if (!extIsSupported("GL_NV_vertex_buffer_unified_memory"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBufferAddressRangeNV, "glBufferAddressRangeNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexFormatNV, "glVertexFormatNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalFormatNV, "glNormalFormatNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorFormatNV, "glColorFormatNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIndexFormatNV, "glIndexFormatNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoordFormatNV, "glTexCoordFormatNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEdgeFlagFormatNV, "glEdgeFlagFormatNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColorFormatNV, "glSecondaryColorFormatNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFogCoordFormatNV, "glFogCoordFormatNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribFormatNV, "glVertexAttribFormatNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexAttribIFormatNV, "glVertexAttribIFormatNV"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetIntegerui64i_vNV, "glGetIntegerui64i_vNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_NV_texture_barrier()
		{
			if (!extIsSupported("GL_NV_texture_barrier"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTextureBarrierNV, "glTextureBarrierNV"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_ATI)
	{
		GLExtensionState load_GL_ATI_texture_mirror_once()
		{
			if (!extIsSupported("GL_ATI_texture_mirror_once"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_envmap_bumpmap()
		{
			if (!extIsSupported("GL_ATI_envmap_bumpmap"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTexBumpParameterivATI, "glTexBumpParameterivATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexBumpParameterfvATI, "glTexBumpParameterfvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTexBumpParameterivATI, "glGetTexBumpParameterivATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTexBumpParameterfvATI, "glGetTexBumpParameterfvATI"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_fragment_shader()
		{
			if (!extIsSupported("GL_ATI_fragment_shader"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGenFragmentShadersATI, "glGenFragmentShadersATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBindFragmentShaderATI, "glBindFragmentShaderATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteFragmentShaderATI, "glDeleteFragmentShaderATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBeginFragmentShaderATI, "glBeginFragmentShaderATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEndFragmentShaderATI, "glEndFragmentShaderATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPassTexCoordATI, "glPassTexCoordATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSampleMapATI, "glSampleMapATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorFragmentOp1ATI, "glColorFragmentOp1ATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorFragmentOp2ATI, "glColorFragmentOp2ATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorFragmentOp3ATI, "glColorFragmentOp3ATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glAlphaFragmentOp1ATI, "glAlphaFragmentOp1ATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glAlphaFragmentOp2ATI, "glAlphaFragmentOp2ATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glAlphaFragmentOp3ATI, "glAlphaFragmentOp3ATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSetFragmentShaderConstantATI, "glSetFragmentShaderConstantATI"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_pn_triangles()
		{
			if (!extIsSupported("GL_ATI_pn_triangles"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glPNTrianglesiATI, "glPNTrianglesiATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPNTrianglesfATI, "glPNTrianglesfATI"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_vertex_array_object()
		{
			if (!extIsSupported("GL_ATI_vertex_array_object"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glNewObjectBufferATI, "glNewObjectBufferATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsObjectBufferATI, "glIsObjectBufferATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUpdateObjectBufferATI, "glUpdateObjectBufferATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetObjectBufferfvATI, "glGetObjectBufferfvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetObjectBufferivATI, "glGetObjectBufferivATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFreeObjectBufferATI, "glFreeObjectBufferATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glArrayObjectATI, "glArrayObjectATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetArrayObjectfvATI, "glGetArrayObjectfvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetArrayObjectivATI, "glGetArrayObjectivATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVariantArrayObjectATI, "glVariantArrayObjectATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVariantArrayObjectfvATI, "glGetVariantArrayObjectfvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVariantArrayObjectivATI, "glGetVariantArrayObjectivATI"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_vertex_streams()
		{
			if (!extIsSupported("GL_ATI_vertex_streams"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glVertexStream1sATI, "glVertexStream1sATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream1svATI, "glVertexStream1svATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream1iATI, "glVertexStream1iATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream1ivATI, "glVertexStream1ivATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream1fATI, "glVertexStream1fATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream1fvATI, "glVertexStream1fvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream1dATI, "glVertexStream1dATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream1dvATI, "glVertexStream1dvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream2sATI, "glVertexStream2sATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream2svATI, "glVertexStream2svATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream2iATI, "glVertexStream2iATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream2ivATI, "glVertexStream2ivATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream2fATI, "glVertexStream2fATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream2fvATI, "glVertexStream2fvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream2dATI, "glVertexStream2dATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream2dvATI, "glVertexStream2dvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream3sATI, "glVertexStream3sATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream3svATI, "glVertexStream3svATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream3iATI, "glVertexStream3iATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream3ivATI, "glVertexStream3ivATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream3fATI, "glVertexStream3fATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream3fvATI, "glVertexStream3fvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream3dATI, "glVertexStream3dATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream3dvATI, "glVertexStream3dvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream4sATI, "glVertexStream4sATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream4svATI, "glVertexStream4svATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream4iATI, "glVertexStream4iATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream4ivATI, "glVertexStream4ivATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream4fATI, "glVertexStream4fATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream4fvATI, "glVertexStream4fvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream4dATI, "glVertexStream4dATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexStream4dvATI, "glVertexStream4dvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalStream3bATI, "glNormalStream3bATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalStream3bvATI, "glNormalStream3bvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalStream3sATI, "glNormalStream3sATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalStream3svATI, "glNormalStream3svATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalStream3iATI, "glNormalStream3iATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalStream3ivATI, "glNormalStream3ivATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalStream3fATI, "glNormalStream3fATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalStream3fvATI, "glNormalStream3fvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalStream3dATI, "glNormalStream3dATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalStream3dvATI, "glNormalStream3dvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glClientActiveVertexStreamATI, "glClientActiveVertexStreamATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexBlendEnviATI, "glVertexBlendEnviATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexBlendEnvfATI, "glVertexBlendEnvfATI"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_element_array()
		{
			if (!extIsSupported("GL_ATI_element_array"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glElementPointerATI, "glElementPointerATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDrawElementArrayATI, "glDrawElementArrayATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDrawRangeElementArrayATI, "glDrawRangeElementArrayATI"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_text_fragment_shader()
		{
			if (!extIsSupported("GL_ATI_text_fragment_shader"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_draw_buffers()
		{
			if (!extIsSupported("GL_ATI_draw_buffers"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDrawBuffersATI, "glDrawBuffersATI"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_pixel_format_float()
		{
			if (!extIsSupported("GL_ATI_pixel_format_float"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_texture_env_combine3()
		{
			if (!extIsSupported("GL_ATI_texture_env_combine3"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_texture_float()
		{
			if (!extIsSupported("GL_ATI_texture_float"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_map_object_buffer()
		{
			if (!extIsSupported("GL_ATI_map_object_buffer"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glMapBufferATI, "glMapBufferATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glUnmapBufferATI, "glUnmapBufferATI"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_separate_stencil()
		{
			if (!extIsSupported("GL_ATI_separate_stencil"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glStencilOpSeparateATI, "glStencilOpSeparateATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glStencilFuncSeparateATI, "glStencilFuncSeparateATI"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_vertex_attrib_array_object()
		{
			if (!extIsSupported("GL_ATI_vertex_attrib_array_object"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glVertexAttribArrayObjectATI, "glVertexAttribArrayObjectATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVertexAttribArrayObjectfvATI, "glGetVertexAttribArrayObjectfvATI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetVertexAttribArrayObjectivATI, "glGetVertexAttribArrayObjectivATI"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_ATI_meminfo()
		{
			if (!extIsSupported("GL_ATI_meminfo"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_AMD)
	{
		GLExtensionState load_GL_AMD_performance_monitor()
		{
			if (!extIsSupported("GL_AMD_performance_monitor"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGetPerfMonitorGroupsAMD, "glGetPerfMonitorGroupsAMD"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetPerfMonitorCountersAMD, "glGetPerfMonitorCountersAMD"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetPerfMonitorGroupStringAMD, "glGetPerfMonitorGroupStringAMD"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetPerfMonitorCounterStringAMD, "glGetPerfMonitorCounterStringAMD"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetPerfMonitorCounterInfoAMD, "glGetPerfMonitorCounterInfoAMD"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenPerfMonitorsAMD, "glGenPerfMonitorsAMD"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeletePerfMonitorsAMD, "glDeletePerfMonitorsAMD"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSelectPerfMonitorCountersAMD, "glSelectPerfMonitorCountersAMD"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBeginPerfMonitorAMD, "glBeginPerfMonitorAMD"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEndPerfMonitorAMD, "glEndPerfMonitorAMD"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetPerfMonitorCounterDataAMD, "glGetPerfMonitorCounterDataAMD"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_AMD_texture_texture4()
		{
			if (!extIsSupported("GL_AMD_texture_texture4"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_AMD_vertex_shader_tesselator()
		{
			if (!extIsSupported("GL_AMD_vertex_shader_tesselator"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTessellationFactorAMD, "glTessellationFactorAMD"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTessellationModeAMD, "glTessellationModeAMD"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_AMD_draw_buffers_blend()
		{
			if (!extIsSupported("GL_AMD_draw_buffers_blend"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBlendFuncIndexedAMD, "glBlendFuncIndexedAMD"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBlendFuncSeparateIndexedAMD, "glBlendFuncSeparateIndexedAMD"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBlendEquationIndexedAMD, "glBlendEquationIndexedAMD"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glBlendEquationSeparateIndexedAMD, "glBlendEquationSeparateIndexedAMD"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_SGI)
	{
		GLExtensionState load_GL_SGI_color_matrix()
		{
			if (!extIsSupported("GL_SGI_color_matrix"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGI_color_table()
		{
			if (!extIsSupported("GL_SGI_color_table"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glColorTableSGI, "glColorTableSGI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorTableParameterfvSGI, "glColorTableParameterfvSGI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorTableParameterivSGI, "glColorTableParameterivSGI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glCopyColorTableSGI, "glCopyColorTableSGI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetColorTableSGI, "glGetColorTableSGI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetColorTableParameterfvSGI, "glGetColorTableParameterfvSGI"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetColorTableParameterivSGI, "glGetColorTableParameterivSGI"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGI_texture_color_table()
		{
			if (!extIsSupported("GL_SGI_texture_color_table"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_SGIS)
	{
		GLExtensionState load_GL_SGIS_texture_filter4()
		{
			if (!extIsSupported("GL_SGIS_texture_filter4"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGetTexFilterFuncSGIS, "glGetTexFilterFuncSGIS"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexFilterFuncSGIS, "glTexFilterFuncSGIS"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIS_pixel_texture()
		{
			if (!extIsSupported("GL_SGIS_pixel_texture"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glPixelTexGenParameteriSGIS, "glPixelTexGenParameteriSGIS"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPixelTexGenParameterivSGIS, "glPixelTexGenParameterivSGIS"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPixelTexGenParameterfSGIS, "glPixelTexGenParameterfSGIS"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPixelTexGenParameterfvSGIS, "glPixelTexGenParameterfvSGIS"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetPixelTexGenParameterivSGIS, "glGetPixelTexGenParameterivSGIS"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetPixelTexGenParameterfvSGIS, "glGetPixelTexGenParameterfvSGIS"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIS_texture4D()
		{
			if (!extIsSupported("GL_SGIS_texture4D"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTexImage4DSGIS, "glTexImage4DSGIS"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexSubImage4DSGIS, "glTexSubImage4DSGIS"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIS_detail_texture()
		{
			if (!extIsSupported("GL_SGIS_detail_texture"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDetailTexFuncSGIS, "glDetailTexFuncSGIS"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetDetailTexFuncSGIS, "glGetDetailTexFuncSGIS"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIS_sharpen_texture()
		{
			if (!extIsSupported("GL_SGIS_sharpen_texture"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glSharpenTexFuncSGIS, "glSharpenTexFuncSGIS"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetSharpenTexFuncSGIS, "glGetSharpenTexFuncSGIS"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIS_texture_lod()
		{
			if (!extIsSupported("GL_SGIS_texture_lod"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIS_multisample()
		{
			if (!extIsSupported("GL_SGIS_multisample"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glSampleMaskSGIS, "glSampleMaskSGIS"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSamplePatternSGIS, "glSamplePatternSGIS"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIS_generate_mipmap()
		{
			if (!extIsSupported("GL_SGIS_generate_mipmap"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIS_texture_edge_clamp()
		{
			if (!extIsSupported("GL_SGIS_texture_edge_clamp"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIS_texture_border_clamp()
		{
			if (!extIsSupported("GL_SGIS_texture_border_clamp"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIS_texture_select()
		{
			if (!extIsSupported("GL_SGIS_texture_select"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIS_point_parameters()
		{
			if (!extIsSupported("GL_SGIS_point_parameters"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glPointParameterfSGIS, "glPointParameterfSGIS"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPointParameterfvSGIS, "glPointParameterfvSGIS"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIS_fog_function()
		{
			if (!extIsSupported("GL_SGIS_fog_function"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glFogFuncSGIS, "glFogFuncSGIS"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFogFuncSGIS, "glGetFogFuncSGIS"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIS_point_line_texgen()
		{
			if (!extIsSupported("GL_SGIS_point_line_texgen"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIS_texture_color_mask()
		{
			if (!extIsSupported("GL_SGIS_texture_color_mask"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTextureColorMaskSGIS, "glTextureColorMaskSGIS"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_SGIX)
	{
		GLExtensionState load_GL_SGIX_pixel_texture()
		{
			if (!extIsSupported("GL_SGIX_pixel_texture"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glPixelTexGenSGIX, "glPixelTexGenSGIX"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_clipmap()
		{
			if (!extIsSupported("GL_SGIX_clipmap"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_shadow()
		{
			if (!extIsSupported("GL_SGIX_shadow"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_interlace()
		{
			if (!extIsSupported("GL_SGIX_interlace"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_pixel_tiles()
		{
			if (!extIsSupported("GL_SGIX_pixel_tiles"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_sprite()
		{
			if (!extIsSupported("GL_SGIX_sprite"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glSpriteParameterfSGIX, "glSpriteParameterfSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSpriteParameterfvSGIX, "glSpriteParameterfvSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSpriteParameteriSGIX, "glSpriteParameteriSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSpriteParameterivSGIX, "glSpriteParameterivSGIX"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_texture_multi_buffer()
		{
			if (!extIsSupported("GL_SGIX_texture_multi_buffer"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_instruments()
		{
			if (!extIsSupported("GL_SGIX_instruments"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGetInstrumentsSGIX, "glGetInstrumentsSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glInstrumentsBufferSGIX, "glInstrumentsBufferSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPollInstrumentsSGIX, "glPollInstrumentsSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReadInstrumentsSGIX, "glReadInstrumentsSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glStartInstrumentsSGIX, "glStartInstrumentsSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glStopInstrumentsSGIX, "glStopInstrumentsSGIX"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_texture_scale_bias()
		{
			if (!extIsSupported("GL_SGIX_texture_scale_bias"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_framezoom()
		{
			if (!extIsSupported("GL_SGIX_framezoom"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glFrameZoomSGIX, "glFrameZoomSGIX"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_tag_sample_buffer()
		{
			if (!extIsSupported("GL_SGIX_tag_sample_buffer"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTagSampleBufferSGIX, "glTagSampleBufferSGIX"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_polynomial_ffd()
		{
			if (!extIsSupported("GL_SGIX_polynomial_ffd"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDeformationMap3dSGIX, "glDeformationMap3dSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeformationMap3fSGIX, "glDeformationMap3fSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeformSGIX, "glDeformSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glLoadIdentityDeformationMapSGIX, "glLoadIdentityDeformationMapSGIX"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_reference_plane()
		{
			if (!extIsSupported("GL_SGIX_reference_plane"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glReferencePlaneSGIX, "glReferencePlaneSGIX"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_flush_raster()
		{
			if (!extIsSupported("GL_SGIX_flush_raster"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glFLushRasterSGIX, "glFLushRasterSGIX"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_depth_texture()
		{
			if (!extIsSupported("GL_SGIX_depth_texture"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_fog_offset()
		{
			if (!extIsSupported("GL_SGIX_fog_offset"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_texture_add_env()
		{
			if (!extIsSupported("GL_SGIX_texture_add_env"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_list_priority()
		{
			if (!extIsSupported("GL_SGIX_list_priority"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGetListParameterfvSGIX, "glGetListParameterfvSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetListParameterivSGIX, "glGetListParameterivSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glListParameterfSGIX, "glListParameterfSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glListParameterfvSGIX, "glListParameterfvSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glListParameteriSGIX, "glListParameteriSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glListParameterivSGIX, "glListParameterivSGIX"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_ir_instrument1()
		{
			if (!extIsSupported("GL_SGIX_ir_instrument1"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_calligraphic_fragment()
		{
			if (!extIsSupported("GL_SGIX_calligraphic_fragment"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_texture_lod_bias()
		{
			if (!extIsSupported("GL_SGIX_texture_lod_bias"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_shadow_ambient()
		{
			if (!extIsSupported("GL_SGIX_shadow_ambient"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_ycrcb()
		{
			if (!extIsSupported("GL_SGIX_ycrcb"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_fragment_lighting()
		{
			if (!extIsSupported("GL_SGIX_fragment_lighting"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glFragmentColorMaterialSGIX, "glFragmentColorMaterialSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFragmentLightfSGIX, "glFragmentLightfSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFragmentLightfvSGIX, "glFragmentLightfvSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFragmentLightiSGIX, "glFragmentLightiSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFragmentLightivSGIX, "glFragmentLightivSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFragmentLightModelfSGIX, "glFragmentLightModelfSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFragmentLightModelfvSGIX, "glFragmentLightModelfvSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFragmentLightModeliSGIX, "glFragmentLightModeliSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFragmentLightModelivSGIX, "glFragmentLightModelivSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFragmentMaterialfSGIX, "glFragmentMaterialfSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFragmentMaterialfvSGIX, "glFragmentMaterialfvSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFragmentMaterialiSGIX, "glFragmentMaterialiSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFragmentMaterialivSGIX, "glFragmentMaterialivSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFragmentLightfvSGIX, "glGetFragmentLightfvSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFragmentLightivSGIX, "glGetFragmentLightivSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFragmentMaterialfvSGIX, "glGetFragmentMaterialfvSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetFragmentMaterialivSGIX, "glGetFragmentMaterialivSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glLightEnviSGIX, "glLightEnviSGIX"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_blend_alpha_minmax()
		{
			if (!extIsSupported("GL_SGIX_blend_alpha_minmax"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_impact_pixel_texture()
		{
			if (!extIsSupported("GL_SGIX_impact_pixel_texture"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_async()
		{
			if (!extIsSupported("GL_SGIX_async"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glAsyncMarkerSGIX, "glAsyncMarkerSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFinishAsyncSGIX, "glFinishAsyncSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glPollAsyncSGIX, "glPollAsyncSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenAsyncMarkersSGIX, "glGenAsyncMarkersSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteAsyncMarkersSGIX, "glDeleteAsyncMarkersSGIX"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsAsyncMarkerSGIX, "glIsAsyncMarkerSGIX"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_async_pixel()
		{
			if (!extIsSupported("GL_SGIX_async_pixel"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_async_histogram()
		{
			if (!extIsSupported("GL_SGIX_async_histogram"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_fog_scale()
		{
			if (!extIsSupported("GL_SGIX_fog_scale"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_subsample()
		{
			if (!extIsSupported("GL_SGIX_subsample"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_ycrcb_subsample()
		{
			if (!extIsSupported("GL_SGIX_ycrcb_subsample"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_ycrcba()
		{
			if (!extIsSupported("GL_SGIX_ycrcba"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_depth_pass_instrument()
		{
			if (!extIsSupported("GL_SGIX_depth_pass_instrument"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_vertex_preclip()
		{
			if (!extIsSupported("GL_SGIX_vertex_preclip"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_convolution_accuracy()
		{
			if (!extIsSupported("GL_SGIX_convolution_accuracy"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_resample()
		{
			if (!extIsSupported("GL_SGIX_resample"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_texture_coordinate_clamp()
		{
			if (!extIsSupported("GL_SGIX_texture_coordinate_clamp"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SGIX_scalebias_hint()
		{
			if (!extIsSupported("GL_SGIX_scalebias_hint"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_HP)
	{
		GLExtensionState load_GL_HP_image_transform()
		{
			if (!extIsSupported("GL_HP_image_transform"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glImageTransformParameteriHP, "glImageTransformParameteriHP"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glImageTransformParameterfHP, "glImageTransformParameterfHP"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glImageTransformParameterivHP, "glImageTransformParameterivHP"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glImageTransformParameterfvHP, "glImageTransformParameterfvHP"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetImageTransformParameterivHP, "glGetImageTransformParameterivHP"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetImageTransformParameterfvHP, "glGetImageTransformParameterfvHP"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_HP_convolution_border_modes()
		{
			if (!extIsSupported("GL_HP_convolution_border_modes"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_HP_texture_lighting()
		{
			if (!extIsSupported("GL_HP_texture_lighting"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_HP_occlusion_test()
		{
			if (!extIsSupported("GL_HP_occlusion_test"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_PGI)
	{
		GLExtensionState load_GL_PGI_vertex_hints()
		{
			if (!extIsSupported("GL_PGI_vertex_hints"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_PGI_misc_hints()
		{
			if (!extIsSupported("GL_PGI_misc_hints"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glHintPGI, "glHintPGI"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_IBM)
	{
		GLExtensionState load_GL_IBM_rasterpos_clip()
		{
			if (!extIsSupported("GL_IBM_rasterpos_clip"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_IBM_cull_vertex()
		{
			if (!extIsSupported("GL_IBM_cull_vertex"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_IBM_multimode_draw_arrays()
		{
			if (!extIsSupported("GL_IBM_multimode_draw_arrays"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glMultiModeDrawArraysIBM, "glMultiModeDrawArraysIBM"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiModeDrawElementsIBM, "glMultiModeDrawElementsIBM"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_IBM_vertex_array_lists()
		{
			if (!extIsSupported("GL_IBM_vertex_array_lists"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glColorPointerListIBM, "glColorPointerListIBM"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSecondaryColorPointerListIBM, "glSecondaryColorPointerListIBM"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glEdgeFlagPointerListIBM, "glEdgeFlagPointerListIBM"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFogCoordPointerListIBM, "glFogCoordPointerListIBM"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIndexPointerListIBM, "glIndexPointerListIBM"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalPointerListIBM, "glNormalPointerListIBM"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoordPointerListIBM, "glTexCoordPointerListIBM"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexPointerListIBM, "glVertexPointerListIBM"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_IBM_texture_mirrored_repeat()
		{
			if (!extIsSupported("GL_IBM_texture_mirrored_repeat"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_WIN)
	{
		GLExtensionState load_GL_WIN_phong_shading()
		{
			if (!extIsSupported("GL_WIN_phong_shading"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_WIN_specular_fog()
		{
			if (!extIsSupported("GL_WIN_specular_fog"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_INTEL)
	{
		GLExtensionState load_GL_INTEL_parallel_arrays()
		{
			if (!extIsSupported("GL_INTEL_parallel_arrays"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glVertexPointervINTEL, "glVertexPointervINTEL"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormalPointervINTEL, "glNormalPointervINTEL"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColorPointervINTEL, "glColorPointervINTEL"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoordPointervINTEL, "glTexCoordPointervINTEL"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_REND)
	{
		GLExtensionState load_GL_REND_screen_coordinates()
		{
			if (!extIsSupported("GL_REND_screen_coordinates"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_APPLE)
	{
		GLExtensionState load_GL_APPLE_specular_vector()
		{
			if (!extIsSupported("GL_APPLE_specular_vector"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_transform_hint()
		{
			if (!extIsSupported("GL_APPLE_transform_hint"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_client_storage()
		{
			if (!extIsSupported("GL_APPLE_client_storage"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_element_array()
		{
			if (!extIsSupported("GL_APPLE_element_array"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glElementPointerAPPLE, "glElementPointerAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDrawElementArrayAPPLE, "glDrawElementArrayAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDrawRangeElementArrayAPPLE, "glDrawRangeElementArrayAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiDrawElementArrayAPPLE, "glMultiDrawElementArrayAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMultiDrawRangeElementArrayAPPLE, "glMultiDrawRangeElementArrayAPPLE"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_fence()
		{
			if (!extIsSupported("GL_APPLE_fence"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGenFencesAPPLE, "glGenFencesAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteFencesAPPLE, "glDeleteFencesAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glSetFenceAPPLE, "glSetFenceAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsFenceAPPLE, "glIsFenceAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTestFenceAPPLE, "glTestFenceAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFinishFenceAPPLE, "glFinishFenceAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTestObjectAPPLE, "glTestObjectAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFinishObjectAPPLE, "glFinishObjectAPPLE"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_vertex_array_object()
		{
			if (!extIsSupported("GL_APPLE_vertex_array_object"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBindVertexArrayAPPLE, "glBindVertexArrayAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDeleteVertexArraysAPPLE, "glDeleteVertexArraysAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGenVertexArraysAPPLE, "glGenVertexArraysAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsVertexArrayAPPLE, "glIsVertexArrayAPPLE"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_vertex_array_range()
		{
			if (!extIsSupported("GL_APPLE_vertex_array_range"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glVertexArrayRangeAPPLE, "glVertexArrayRangeAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFlushVertexArrayRangeAPPLE, "glFlushVertexArrayRangeAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glVertexArrayParameteriAPPLE, "glVertexArrayParameteriAPPLE"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_ycbcr_422()
		{
			if (!extIsSupported("GL_APPLE_ycbcr_422"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_flush_buffer_range()
		{
			if (!extIsSupported("GL_APPLE_flush_buffer_range"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glBufferParameteriAPPLE, "glBufferParameteriAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glFlushMappedBufferRangeAPPLE, "glFlushMappedBufferRangeAPPLE"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_texture_range()
		{
			if (!extIsSupported("GL_APPLE_texture_range"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTextureRangeAPPLE, "glTextureRangeAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetTexParameterPointervAPPLE, "glGetTexParameterPointervAPPLE"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_float_pixels()
		{
			if (!extIsSupported("GL_APPLE_float_pixels"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_vertex_program_evaluators()
		{
			if (!extIsSupported("GL_APPLE_vertex_program_evaluators"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glEnableVertexAttribAPPLE, "glEnableVertexAttribAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glDisableVertexAttribAPPLE, "glDisableVertexAttribAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glIsVertexAttribAPPLE, "glIsVertexAttribAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMapVertexAttrib1dAPPLE, "glMapVertexAttrib1dAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMapVertexAttrib1fAPPLE, "glMapVertexAttrib1fAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMapVertexAttrib2dAPPLE, "glMapVertexAttrib2dAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glMapVertexAttrib2fAPPLE, "glMapVertexAttrib2fAPPLE"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_aux_depth_stencil()
		{
			if (!extIsSupported("GL_APPLE_aux_depth_stencil"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_object_purgeable()
		{
			if (!extIsSupported("GL_APPLE_object_purgeable"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glObjectPurgeableAPPLE, "glObjectPurgeableAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glObjectUnpurgeableAPPLE, "glObjectUnpurgeableAPPLE"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGetObjectParameterivAPPLE, "glGetObjectParameterivAPPLE"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_row_bytes()
		{
			if (!extIsSupported("GL_APPLE_row_bytes"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_APPLE_rgb_422()
		{
			if (!extIsSupported("GL_APPLE_rgb_422"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_SUNX)
	{
		GLExtensionState load_GL_SUNX_constant_data()
		{
			if (!extIsSupported("GL_SUNX_constant_data"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glFinishTextureSUNX, "glFinishTextureSUNX"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_SUN)
	{
		GLExtensionState load_GL_SUN_global_alpha()
		{
			if (!extIsSupported("GL_SUN_global_alpha"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glGlobalAlphaFactorbSUN, "glGlobalAlphaFactorbSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGlobalAlphaFactorsSUN, "glGlobalAlphaFactorsSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGlobalAlphaFactoriSUN, "glGlobalAlphaFactoriSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGlobalAlphaFactorfSUN, "glGlobalAlphaFactorfSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGlobalAlphaFactordSUN, "glGlobalAlphaFactordSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGlobalAlphaFactorubSUN, "glGlobalAlphaFactorubSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGlobalAlphaFactorusSUN, "glGlobalAlphaFactorusSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glGlobalAlphaFactoruiSUN, "glGlobalAlphaFactoruiSUN"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SUN_triangle_list()
		{
			if (!extIsSupported("GL_SUN_triangle_list"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiSUN, "glReplacementCodeuiSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeusSUN, "glReplacementCodeusSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeubSUN, "glReplacementCodeubSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuivSUN, "glReplacementCodeuivSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeusvSUN, "glReplacementCodeusvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeubvSUN, "glReplacementCodeubvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodePointerSUN, "glReplacementCodePointerSUN"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SUN_vertex()
		{
			if (!extIsSupported("GL_SUN_vertex"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glColor4ubVertex2fSUN, "glColor4ubVertex2fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColor4ubVertex2fvSUN, "glColor4ubVertex2fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColor4ubVertex3fSUN, "glColor4ubVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColor4ubVertex3fvSUN, "glColor4ubVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColor3fVertex3fSUN, "glColor3fVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColor3fVertex3fvSUN, "glColor3fVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormal3fVertex3fSUN, "glNormal3fVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glNormal3fVertex3fvSUN, "glNormal3fVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColor4fNormal3fVertex3fSUN, "glColor4fNormal3fVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glColor4fNormal3fVertex3fvSUN, "glColor4fNormal3fVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord2fVertex3fSUN, "glTexCoord2fVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord2fVertex3fvSUN, "glTexCoord2fVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord4fVertex4fSUN, "glTexCoord4fVertex4fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord4fVertex4fvSUN, "glTexCoord4fVertex4fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord2fColor4ubVertex3fSUN, "glTexCoord2fColor4ubVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord2fColor4ubVertex3fvSUN, "glTexCoord2fColor4ubVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord2fColor3fVertex3fSUN, "glTexCoord2fColor3fVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord2fColor3fVertex3fvSUN, "glTexCoord2fColor3fVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord2fNormal3fVertex3fSUN, "glTexCoord2fNormal3fVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord2fNormal3fVertex3fvSUN, "glTexCoord2fNormal3fVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord2fColor4fNormal3fVertex3fSUN, "glTexCoord2fColor4fNormal3fVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord2fColor4fNormal3fVertex3fvSUN, "glTexCoord2fColor4fNormal3fVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord4fColor4fNormal3fVertex4fSUN, "glTexCoord4fColor4fNormal3fVertex4fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glTexCoord4fColor4fNormal3fVertex4fvSUN, "glTexCoord4fColor4fNormal3fVertex4fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiVertex3fSUN, "glReplacementCodeuiVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiVertex3fvSUN, "glReplacementCodeuiVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiColor4ubVertex3fSUN, "glReplacementCodeuiColor4ubVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiColor4ubVertex3fvSUN, "glReplacementCodeuiColor4ubVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiColor3fVertex3fSUN, "glReplacementCodeuiColor3fVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiColor3fVertex3fvSUN, "glReplacementCodeuiColor3fVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiNormal3fVertex3fSUN, "glReplacementCodeuiNormal3fVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiNormal3fVertex3fvSUN, "glReplacementCodeuiNormal3fVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiColor4fNormal3fVertex3fSUN, "glReplacementCodeuiColor4fNormal3fVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiColor4fNormal3fVertex3fvSUN, "glReplacementCodeuiColor4fNormal3fVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiTexCoord2fVertex3fSUN, "glReplacementCodeuiTexCoord2fVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiTexCoord2fVertex3fvSUN, "glReplacementCodeuiTexCoord2fVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN, "glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN, "glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN, "glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN, "glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SUN_convolution_border_modes()
		{
			if (!extIsSupported("GL_SUN_convolution_border_modes"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SUN_mesh_array()
		{
			if (!extIsSupported("GL_SUN_mesh_array"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glDrawMeshArraysSUN, "glDrawMeshArraysSUN"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_SUN_slice_accum()
		{
			if (!extIsSupported("GL_SUN_slice_accum"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_INGR)
	{
		GLExtensionState load_GL_INGR_color_clamp()
		{
			if (!extIsSupported("GL_INGR_color_clamp"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_INGR_interlace_read()
		{
			if (!extIsSupported("GL_INGR_interlace_read"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_MESA)
	{
		GLExtensionState load_GL_MESA_resize_buffers()
		{
			if (!extIsSupported("GL_MESA_resize_buffers"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glResizeBuffersMESA, "glResizeBuffersMESA"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_MESA_window_pos()
		{
			if (!extIsSupported("GL_MESA_window_pos"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glWindowPos2dMESA, "glWindowPos2dMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos2dvMESA, "glWindowPos2dvMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos2fMESA, "glWindowPos2fMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos2fvMESA, "glWindowPos2fvMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos2iMESA, "glWindowPos2iMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos2ivMESA, "glWindowPos2ivMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos2sMESA, "glWindowPos2sMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos2svMESA, "glWindowPos2svMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3dMESA, "glWindowPos3dMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3dvMESA, "glWindowPos3dvMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3fMESA, "glWindowPos3fMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3fvMESA, "glWindowPos3fvMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3iMESA, "glWindowPos3iMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3ivMESA, "glWindowPos3ivMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3sMESA, "glWindowPos3sMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos3svMESA, "glWindowPos3svMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos4dMESA, "glWindowPos4dMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos4dvMESA, "glWindowPos4dvMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos4fMESA, "glWindowPos4fMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos4fvMESA, "glWindowPos4fvMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos4iMESA, "glWindowPos4iMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos4ivMESA, "glWindowPos4ivMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos4sMESA, "glWindowPos4sMESA"))
				return GLExtensionState.FailedToLoad;
			if (!bindExtFunc(cast(void**)&glWindowPos4svMESA, "glWindowPos4svMESA"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_MESA_pack_invert()
		{
			if (!extIsSupported("GL_MESA_pack_invert"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_MESA_ycbcr_texture()
		{
			if (!extIsSupported("GL_MESA_ycbcr_texture"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_3DFX)
	{
		GLExtensionState load_GL_3DFX_texture_compression_FXT1()
		{
			if (!extIsSupported("GL_3DFX_texture_compression_FXT1"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_3DFX_multisample()
		{
			if (!extIsSupported("GL_3DFX_multisample"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_3DFX_tbuffer()
		{
			if (!extIsSupported("GL_3DFX_tbuffer"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glTbufferMask3DFX, "glTbufferMask3DFX"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_OML)
	{
		GLExtensionState load_GL_OML_interlace()
		{
			if (!extIsSupported("GL_OML_interlace"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_OML_subsample()
		{
			if (!extIsSupported("GL_OML_subsample"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_OML_resample()
		{
			if (!extIsSupported("GL_OML_resample"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_S3)
	{
		GLExtensionState load_GL_S3_s3tc()
		{
			if (!extIsSupported("GL_S3_s3tc"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_OES)
	{
		GLExtensionState load_GL_OES_read_format()
		{
			if (!extIsSupported("GL_OES_read_format"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_GREMEDY)
	{
		GLExtensionState load_GL_GREMEDY_string_marker()
		{
			if (!extIsSupported("GL_GREMEDY_string_marker"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glStringMarkerGREMEDY, "glStringMarkerGREMEDY"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_GL_GREMEDY_frame_terminator()
		{
			if (!extIsSupported("GL_GREMEDY_frame_terminator"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&glFrameTerminatorGREMEDY, "glFrameTerminatorGREMEDY"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

	}
	version (DerelictGL_MESAX)
	{
		GLExtensionState load_GL_MESAX_texture_stack()
		{
			if (!extIsSupported("GL_MESAX_texture_stack"))
				return GLExtensionState.DriverUnsupported;
			return GLExtensionState.Loaded;
		}

	}
	version (Windows)
	{
		GLExtensionState load_WGL_ARB_extensions_string()
		{
			if (!bindExtFunc(cast(void**)&wglGetExtensionsStringARB, "wglGetExtensionsStringARB"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		GLExtensionState load_WGL_EXT_extensions_string()
		{
			if (!extIsSupported("WGL_EXT_extensions_string"))
				return GLExtensionState.DriverUnsupported;
			if (!bindExtFunc(cast(void**)&wglGetExtensionsStringEXT, "wglGetExtensionsStringEXT"))
				return GLExtensionState.FailedToLoad;
			return GLExtensionState.Loaded;
		}

		version (DerelictGL_ARB)
		{
			GLExtensionState load_WGL_ARB_buffer_region()
			{
				if (!extIsSupported("WGL_ARB_buffer_region"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglCreateBufferRegionARB, "wglCreateBufferRegionARB"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglDeleteBufferRegionARB, "wglDeleteBufferRegionARB"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglSaveBufferRegionARB, "wglSaveBufferRegionARB"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglRestoreBufferRegionARB, "wglRestoreBufferRegionARB"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_ARB_multisample()
			{
				if (!extIsSupported("WGL_ARB_multisample"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_ARB_pixel_format()
			{
				if (!extIsSupported("WGL_ARB_pixel_format"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglGetPixelFormatAttribivARB, "wglGetPixelFormatAttribivARB"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetPixelFormatAttribfvARB, "wglGetPixelFormatAttribfvARB"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglChoosePixelFormatARB, "wglChoosePixelFormatARB"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_ARB_make_current_read()
			{
				if (!extIsSupported("WGL_ARB_make_current_read"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglMakeContextCurrentARB, "wglMakeContextCurrentARB"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetCurrentReadDCARB, "wglGetCurrentReadDCARB"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_ARB_pbuffer()
			{
				if (!extIsSupported("WGL_ARB_pbuffer"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglCreatePbufferARB, "wglCreatePbufferARB"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetPbufferDCARB, "wglGetPbufferDCARB"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglReleasePbufferDCARB, "wglReleasePbufferDCARB"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglDestroyPbufferARB, "wglDestroyPbufferARB"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglQueryPbufferARB, "wglQueryPbufferARB"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_ARB_render_texture()
			{
				if (!extIsSupported("WGL_ARB_render_texture"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglBindTexImageARB, "wglBindTexImageARB"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglReleaseTexImageARB, "wglReleaseTexImageARB"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglSetPbufferAttribARB, "wglSetPbufferAttribARB"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_ARB_pixel_format_float()
			{
				if (!extIsSupported("WGL_ARB_pixel_format_float"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_ARB_create_context()
			{
				if (!extIsSupported("WGL_ARB_create_context"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglCreateContextAttribsARB, "wglCreateContextAttribsARB"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_ARB_framebuffer_sRGB()
			{
				if (!extIsSupported("WGL_ARB_framebuffer_sRGB"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_ARB_create_context_profile()
			{
				if (!extIsSupported("WGL_ARB_create_context_profile"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

		}
		version (DerelictGL_EXT)
		{
			GLExtensionState load_WGL_EXT_depth_float()
			{
				if (!extIsSupported("WGL_EXT_depth_float"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_EXT_display_color_table()
			{
				if (!extIsSupported("WGL_EXT_display_color_table"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglBindDisplayColorTableEXT, "wglBindDisplayColorTableEXT"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglCreateDisplayColorTableEXT, "wglCreateDisplayColorTableEXT"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglDestroyDisplayColorTableEXT, "wglDestroyDisplayColorTableEXT"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglLoadDisplayColorTableEXT, "wglLoadDisplayColorTableEXT"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_EXT_framebuffer_sRGB()
			{
				if (!extIsSupported("WGL_EXT_framebuffer_sRGB"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_EXT_make_current_read()
			{
				if (!extIsSupported("WGL_EXT_make_current_read"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglMakeContextCurrentEXT, "wglMakeContextCurrentEXT"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetCurrentReadDCEXT, "wglGetCurrentReadDCEXT"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_EXT_multisample()
			{
				if (!extIsSupported("WGL_EXT_multisample"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_EXT_pbuffer()
			{
				if (!extIsSupported("WGL_EXT_pbuffer"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglCreatePbufferEXT, "wglCreatePbufferEXT"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglDestroyPbufferEXT, "wglDestroyPbufferEXT"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetPbufferDCEXT, "wglGetPbufferDCEXT"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglQueryPbufferEXT, "wglQueryPbufferEXT"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglReleasePbufferDCEXT, "wglReleasePbufferDCEXT"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_EXT_pixel_format()
			{
				if (!extIsSupported("WGL_EXT_pixel_format"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglChoosePixelFormatEXT, "wglChoosePixelFormatEXT"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetPixelFormatAttribfvEXT, "wglGetPixelFormatAttribfvEXT"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetPixelFormatAttribivEXT, "wglGetPixelFormatAttribivEXT"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_EXT_pixel_format_packed_float()
			{
				if (!extIsSupported("WGL_EXT_pixel_format_packed_float"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_EXT_swap_control()
			{
				if (!extIsSupported("WGL_EXT_swap_control"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglGetSwapIntervalEXT, "wglGetSwapIntervalEXT"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglSwapIntervalEXT, "wglSwapIntervalEXT"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

		}
		version (DerelictGL_NV)
		{
			GLExtensionState load_WGL_NV_copy_image()
			{
				if (!extIsSupported("WGL_NV_copy_image"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglCopyImageSubDataNV, "wglCopyImageSubDataNV"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_NV_float_buffer()
			{
				if (!extIsSupported("WGL_NV_float_buffer"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_NV_gpu_affinity()
			{
				if (!extIsSupported("WGL_NV_gpu_affinity"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglCreateAffinityDCNV, "wglCreateAffinityDCNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglDeleteDCNV, "wglDeleteDCNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglEnumGpuDevicesNV, "wglEnumGpuDevicesNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglEnumGpusFromAffinityDCNV, "wglEnumGpusFromAffinityDCNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglEnumGpusNV, "wglEnumGpusNV"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_NV_multisample_coverage()
			{
				if (!extIsSupported("WGL_NV_multisample_coverage"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_NV_present_video()
			{
				if (!extIsSupported("WGL_NV_present_video"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglBindVideoDeviceNV, "wglBindVideoDeviceNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglEnumerateVideoDevicesNV, "wglEnumerateVideoDevicesNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglQueryCurrentContextNV, "wglQueryCurrentContextNV"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_NV_render_depth_texture()
			{
				if (!extIsSupported("WGL_NV_render_depth_texture"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_NV_render_texture_rectangle()
			{
				if (!extIsSupported("WGL_NV_render_texture_rectangle"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_NV_swap_group()
			{
				if (!extIsSupported("WGL_NV_swap_group"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglBindSwapBarrierNV, "wglBindSwapBarrierNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglJoinSwapGroupNV, "wglJoinSwapGroupNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglQueryFrameCountNV, "wglQueryFrameCountNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglQueryMaxSwapGroupsNV, "wglQueryMaxSwapGroupsNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglQuerySwapGroupNV, "wglQuerySwapGroupNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglResetFrameCountNV, "wglResetFrameCountNV"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_NV_vertex_array_range()
			{
				if (!extIsSupported("WGL_NV_vertex_array_range"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglAllocateMemoryNV, "wglAllocateMemoryNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglFreeMemoryNV, "wglFreeMemoryNV"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_NV_video_output()
			{
				if (!extIsSupported("WGL_NV_video_output"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglBindVideoImageNV, "wglBindVideoImageNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetVideoDeviceNV, "wglGetVideoDeviceNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetVideoInfoNV, "wglGetVideoInfoNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglReleaseVideoDeviceNV, "wglReleaseVideoDeviceNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglReleaseVideoImageNV, "wglReleaseVideoImageNV"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglSendPbufferToVideoNV, "wglSendPbufferToVideoNV"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

		}
		version (DerelictGL_ATI)
		{
			GLExtensionState load_WGL_ATI_pixel_format_float()
			{
				if (!extIsSupported("WGL_ATI_pixel_format_float"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_ATI_render_texture_rectangle()
			{
				if (!extIsSupported("WGL_ATI_render_texture_rectangle"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

		}
		version (DerelictGL_AMD)
		{
			GLExtensionState load_WGL_AMD_gpu_association()
			{
				if (!extIsSupported("WGL_AMD_gpu_association"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglBlitContextFramebufferAMD, "wglBlitContextFramebufferAMD"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglCreateAssociatedContextAMD, "wglCreateAssociatedContextAMD"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglCreateAssociatedContextAttribsAMD, "wglCreateAssociatedContextAttribsAMD"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglDeleteAssociatedContextAMD, "wglDeleteAssociatedContextAMD"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetContextGPUIDAMD, "wglGetContextGPUIDAMD"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetCurrentAssociatedContextAMD, "wglGetCurrentAssociatedContextAMD"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetGPUIDsAMD, "wglGetGPUIDsAMD"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetGPUInfoAMD, "wglGetGPUInfoAMD"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglMakeAssociatedContextCurrentAMD, "wglMakeAssociatedContextCurrentAMD"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

		}
		version (DerelictGL_I3D)
		{
			GLExtensionState load_WGL_I3D_digital_video_control()
			{
				if (!extIsSupported("WGL_I3D_digital_video_control"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglGetDigitalVideoParametersI3D, "wglGetDigitalVideoParametersI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglSetDigitalVideoParametersI3D, "wglSetDigitalVideoParametersI3D"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_I3D_gamma()
			{
				if (!extIsSupported("WGL_I3D_gamma"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglGetGammaTableI3D, "wglGetGammaTableI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetGammaTableParametersI3D, "wglGetGammaTableParametersI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglSetGammaTableI3D, "wglSetGammaTableI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglSetGammaTableParametersI3D, "wglSetGammaTableParametersI3D"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_I3D_genlock()
			{
				if (!extIsSupported("WGL_I3D_genlock"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglDisableGenlockI3D, "wglDisableGenlockI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglEnableGenlockI3D, "wglEnableGenlockI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGenlockSampleRateI3D, "wglGenlockSampleRateI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGenlockSourceDelayI3D, "wglGenlockSourceDelayI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGenlockSourceEdgeI3D, "wglGenlockSourceEdgeI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGenlockSourceI3D, "wglGenlockSourceI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetGenlockSampleRateI3D, "wglGetGenlockSampleRateI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetGenlockSourceDelayI3D, "wglGetGenlockSourceDelayI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetGenlockSourceEdgeI3D, "wglGetGenlockSourceEdgeI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetGenlockSourceI3D, "wglGetGenlockSourceI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglIsEnabledGenlockI3D, "wglIsEnabledGenlockI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglQueryGenlockMaxSourceDelayI3D, "wglQueryGenlockMaxSourceDelayI3D"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_I3D_image_buffer()
			{
				if (!extIsSupported("WGL_I3D_image_buffer"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglAssociateImageBufferEventsI3D, "wglAssociateImageBufferEventsI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglCreateImageBufferI3D, "wglCreateImageBufferI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglDestroyImageBufferI3D, "wglDestroyImageBufferI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglReleaseImageBufferEventsI3D, "wglReleaseImageBufferEventsI3D"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_I3D_swap_frame_lock()
			{
				if (!extIsSupported("WGL_I3D_swap_frame_lock"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglDisableFrameLockI3D, "wglDisableFrameLockI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglEnableFrameLockI3D, "wglEnableFrameLockI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglIsEnabledFrameLockI3D, "wglIsEnabledFrameLockI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglQueryFrameLockMasterI3D, "wglQueryFrameLockMasterI3D"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

			GLExtensionState load_WGL_I3D_swap_frame_usage()
			{
				if (!extIsSupported("WGL_I3D_swap_frame_usage"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglBeginFrameTrackingI3D, "wglBeginFrameTrackingI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglEndFrameTrackingI3D, "wglEndFrameTrackingI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetFrameUsageI3D, "wglGetFrameUsageI3D"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglQueryFrameTrackingI3D, "wglQueryFrameTrackingI3D"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

		}
		version (DerelictGL_OML)
		{
			GLExtensionState load_WGL_OML_sync_control()
			{
				if (!extIsSupported("WGL_OML_sync_control"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglGetMscRateOML, "wglGetMscRateOML"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglGetSyncValuesOML, "wglGetSyncValuesOML"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglSwapBuffersMscOML, "wglSwapBuffersMscOML"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglSwapLayerBuffersMscOML, "wglSwapLayerBuffersMscOML"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglWaitForMscOML, "wglWaitForMscOML"))
					return GLExtensionState.FailedToLoad;
				if (!bindExtFunc(cast(void**)&wglWaitForSbcOML, "wglWaitForSbcOML"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

		}
		version (DerelictGL_3DFX)
		{
			GLExtensionState load_WGL_3DFX_multisample()
			{
				if (!extIsSupported("WGL_3DFX_multisample"))
					return GLExtensionState.DriverUnsupported;
				return GLExtensionState.Loaded;
			}

		}
		version (DerelictGL_3DL)
		{
			GLExtensionState load_WGL_3DL_stereo_control()
			{
				if (!extIsSupported("WGL_3DL_stereo_control"))
					return GLExtensionState.DriverUnsupported;
				if (!bindExtFunc(cast(void**)&wglSetStereoEmitterState3DL, "wglSetStereoEmitterState3DL"))
					return GLExtensionState.FailedToLoad;
				return GLExtensionState.Loaded;
			}

		}
	}
}
