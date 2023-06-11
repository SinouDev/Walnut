project "Walnut"
   kind "StaticLib"
   language "C++"
   cppdialect "C++17"
   targetdir "bin/%{cfg.buildcfg}"
   staticruntime "off"

   files { "src/**.h", "src/**.cpp" }

   includedirs
   {
      "src",

      "../vendor/imgui",
      "../vendor/glfw/include",
      "../vendor/stb_image",

      "$(CUDA_PATH)/include",

      "%{IncludeDir.VulkanSDK}",
      "%{IncludeDir.glm}",
   }

   links
   {
       "ImGui",
       "GLFW",

       "$(CUDA_PATH)/lib/x64/cudart_static.lib",

       "%{Library.Vulkan}",
   }

   targetdir ("bin/" .. outputdir .. "/%{prj.name}")
   objdir ("../bin-int/" .. outputdir .. "/%{prj.name}")

   filter "system:windows"
      systemversion "latest"
      defines { "WL_PLATFORM_WINDOWS" }

   filter "configurations:Debug"
      defines { "WL_DEBUG", "_DEBUG" }
      runtime "Debug"
      symbols "On"

   filter "configurations:Release"
      defines { "WL_RELEASE", "NDEBUG" }
      runtime "Release"
      optimize "Speed"
      symbols "On"

   filter "configurations:Dist"
      defines { "WL_DIST", "NDEBUG" }
      runtime "Release"
      optimize "Speed"
      symbols "Off"