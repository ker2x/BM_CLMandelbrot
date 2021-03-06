' Blitzmax project to render Mandelbrot fractal using OpenCL
'
' Author  : Laurent "ker2x" Laborde
' License : WTFPL 

Import bah.opencl       'OpenCL : For GPGPU. Find it here : http://code.google.com/p/maxmods/
Import brl.GLGraphics   'OpenGL
Import pub.OpenGL       'OpenGL
Import pub.Glew         'See : http://www.opengl.org/sdk/libs/GLEW/
Import brl.StandardIO   'stdio


'Const
'-----
Const SCREEN_WIDTH:Int = 512  'Screen Width
Const SCREEN_HEIGHT:Int = 512 'Screen Height
Const SCREEN_SIZE:Int = SCREEN_WIDTH * SCREEN_HEIGHT

'Variable
'--------

'OpenGL stuff
Global screen_tex:Int

'Fractal stuff
Global complexLeft:Float = -1.5    'Min cX
Global complexRight:Float = 1.5    'Max cX

Global complexBottom:Float = -1.5  'Min cY
Global complexTop:Float = 1.5      'Max cY

Global complexWidth:Float = complexRight - complexLeft
Global complexHeight:Float = complexBottom - complexTop

Global complex_Buffer:Float[] = New Float[SCREEN_SIZE]
Global pixel_Buffer:Int[] = New Int[SCREEN_SIZE]

'OpenCL Setup
'------------
Local platform:TCLPlatform = TCLPlatform.InitDevice(CL_DEVICE_TYPE_ALL)
'Local program:TCLProgram = platform.LoadProgram(LoadString("mandelbrot.cl"))
'Local kernelMandel:TCLKernel = program.LoadKernel("mandel")

Global workDim:Int = 1
Global globalWorkSize:Int[workDim]
Global localWorkSize:Int[workDim]

globalWorkSize[0] = SCREEN_SIZE
localWorkSize[0] = 1   '128

Global cl_InputBuffer:TCLBuffer
Global cl_OutputBuffer:TCLBuffer

cl_InputBuffer = platform.CreateBuffer(CL_MEM_READ_ONLY | CL_MEM_USE_HOST_PTR, SCREEN_SIZE * 4, complex_Buffer)
cl_OutputBuffer = platform.CreateBuffer(CL_MEM_WRITE_ONLY, SCREEN_SIZE * 4)

'OpenGL Setup
'------------

'Use raw OpenGL Graphic driver
SetGraphicsDriver(GLGraphicsDriver())

'Create OpenGL graphics context
GLGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, 0, 60, GRAPHICS_BACKBUFFER)

'Initialize OpenGL Extension
glewInit()

glClearColor(0.0, 0.0, 0.0, 1.0)

'Lower Left corner of the viewport : 0,0
'width and height of the viewport : SCREEN_WIDTH, SCREEN_HEIGHT
glViewport(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

glDisable(GL_DEPTH_TEST)   'completely disables anything related to the depth buffer
glDisable(GL_LIGHTING)     'disable lightning

	
glMatrixMode(GL_PROJECTION)
glLoadIdentity()
gluOrtho2D(0, SCREEN_WIDTH, SCREEN_HEIGHT, 0)   'parallel projection : x=0->SCREEN_WIDTH, y=0->SCREEN_HEIGHT

glMatrixMode(GL_MODELVIEW)
glLoadIdentity()
glEnable(GL_BLEND) 'Oh mighty OGL, please doth some nice alpha blending in thy rendering pipeline
glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)


'OpenGL Display Function
Function Display()
    glDisable(GL_DEPTH_TEST)
    glDisable(GL_LIGHTING)
	glEnable(GL_TEXTURE_2D)
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE)
	
    glMatrixMode(GL_PROJECTION) ;
    glPushMatrix();
    glLoadIdentity();
    glOrtho(0, SCREEN_WIDTH, SCREEN_HEIGHT, 0, -1, 1)

    glMatrixMode( GL_MODELVIEW);
    glLoadIdentity();

    glViewport(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) ;

    glBegin(GL_QUADS);

    glTexCoord2f(0.0, 0.0);
    glVertex2f(0.0, 0.0) ;

    glTexCoord2f(1.0, 0.0);
    glVertex2f(SCREEN_WIDTH, 0) ;

    glTexCoord2f(1.0, 1.0);
    glVertex2f(SCREEN_WIDTH, SCREEN_HEIGHT) ;

    glTexCoord2f(0.0, 1.0);
    glVertex2f(0, SCREEN_HEIGHT) ;

    glEnd();

    glMatrixMode(GL_PROJECTION);
    glPopMatrix();
	
	glDisable(GL_TEXTURE_2D) ;
End Function





