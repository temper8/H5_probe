# makefile for microsoft nmake

#
# Location of HDF5 binaries (with include/ and lib/ underneath)
HDF5 = C:/HDF_Group/HDF5/1.12.1

# Location of External Libraries
LIBZ    =  C:/HDF_Group/HDF5/1.12.1/lib/libzlib.lib
LIBSZ   =  C:/HDF_Group/HDF5/1.12.1/lib/libsz.lib

# ------ No machine-specific paths/variables after this  -----

FORTRANLIB=-I$(HDF5)/include/static $(HDF5)/lib/libhdf5_fortran.lib  $(HDF5)/lib/hdf5_f90cstub.lib $(HDF5)/lib/libaec.lib 
FSOURCE = dsetexample fileexample
OBJECTS = dsetexample.o fileexample.o

FLAGS   = -c 
LIBSHDF   =  $(FORTRANLIB) $(HDF5)/lib/libhdf5.lib  $(HDF5)/lib/hdf5_tools.lib
LIBZZ       = $(LIBZ) $(LIBSZ) -lm



#Compiler
FC = ifort
#FCFLAGS = -Od  #disable optimisation
#FCFLAGS = -Od  -C /debug:full /traceback /Qcoarray:shared /Qcoarray-num-images:4
#FCFLAGS = -Ofast  /Qopenmp /Qcoarray:shared 
FCFLAGS = -Ofast  -static#The aggressive optimizations
#FCFLAGS = -Ofast /Qparallel /Qopenmp /Qopt-report #the auto-parallelizer
#FCFLAGS = -Ofast /Qparallel /Qopenmp #the auto-parallelizer

COMPILE = $(FC) $(FCFLAGS) $(TARGET_ARCH) -c 


objects = converter.obj

converter : $(objects)
    $(FC) -o converter.exe $(FCFLAGS) $(objects) 

h5ex : $(objects)
    $(FC) -o h5ex_d_rdwr.exe $(FCFLAGS) h5ex_d_rdwr.f90  $(LIBSHDF)  $(LIBZZ) 
    # /link /NODEFAULTLIB:"msvcrt.lib"

.f90.obj: 
    $(COMPILE) $<

clean:
    del *.mod 
    del *.obj
    del *.optrpt
    del *.exe