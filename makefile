# makefile for microsoft nmake

#Compiler
FC = ifort
#FCFLAGS = -Od  #disable optimisation
#FCFLAGS = -Od  -C /debug:full /traceback /Qcoarray:shared /Qcoarray-num-images:4
#FCFLAGS = -Ofast  /Qopenmp /Qcoarray:shared 
FCFLAGS = -Ofast #The aggressive optimizations
#FCFLAGS = -Ofast /Qparallel /Qopenmp /Qopt-report #the auto-parallelizer
#FCFLAGS = -Ofast /Qparallel /Qopenmp #the auto-parallelizer

COMPILE = $(FC) $(FCFLAGS) $(TARGET_ARCH) -c 


objects = converter.obj

grill_exe : $(objects)
    $(FC) -o converter.exe $(FCFLAGS) $(objects) $(MKLFLAGS) 

.f90.obj: 
    $(COMPILE) $<

clean:
    del *.mod 
    del *.obj
    del *.optrpt
    del *.exe