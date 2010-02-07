' Blitzmax project to render Mandelbrot fractal using OpenCL
'
' Author  : Laurent "ker2x" Laborde
' License : WTFPL 

Import bah.opencl       'OpenCL : For GPGPU. Find it here : http://code.google.com/p/maxmods/
Import brl.GLGraphics   'OpenGL
Import pub.OpenGL       'OpenGL
Import pub.Glew         'OpenGL Extension
Import brl.StandardIO   'stdio

''Initialize OpenCL Device
'Local platform:TCLPlatform = TCLPlatform.InitDevice(CL_DEVICE_TYPE_ALL)
'Local program:TCLProgram = platform.LoadProgram(LoadString("mandelbrot.cl"))
'Local kernelMandel:TCLKernel = program.LoadKernel("mandel")

