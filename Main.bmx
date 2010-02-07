' Blitzmax project to render Mandelbrot fractal using OpenCL
'
' Author  : Laurent "ker2x" Laborde
' License : WTFPL 

Import bah.opencl       'OpenCL : For GPGPU. Find it here : http://code.google.com/p/maxmods/
Import brl.GLGraphics   'OpenGL
Import pub.OpenGL       'OpenGL
Import pub.Glew         'OpenGL Extension
Import brl.StandardIO   'stdio


'Const
'-----
Const SCREEN_WIDTH:Int = 512  'Screen Width
Const SCREEN_HEIGHT:Int = 512 'Screen Height


'OpenCL Setup
'------------
'Local platform:TCLPlatform = TCLPlatform.InitDevice(CL_DEVICE_TYPE_ALL)
'Local program:TCLProgram = platform.LoadProgram(LoadString("mandelbrot.cl"))
'Local kernelMandel:TCLKernel = program.LoadKernel("mandel")


'OpenGL Setup
'------------

GLGraphics(SCREEN_WIDTH, SCREEN_HEIGHT)   'Create OpenGL graphics context

glewInit()  'Initialize OpenGL Extension

glMatrixMode(GL_PROJECTION)
glLoadIdentity()
glOrtho(0, GWIDTH, GHEIGHT, 0, -1, 1)

glMatrixMode(GL_MODELVIEW)
glLoadIdentity()
glEnable(GL_BLEND) 'Oh mighty OGL, please doth some nice alpha blending in thy rendering pipeline
glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)


