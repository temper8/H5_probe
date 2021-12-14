# makefile for microsoft nmake

#
# Location of HDF5 binaries (with include/ and lib/ underneath)
HDF5 = C:/HDF_Group/HDF5/1.12.1

# Location of External Libraries
LIBZ    =  C:/HDF_Group/HDF5/1.12.1/lib/libzlib.lib
LIBSZ   =  C:/HDF_Group/HDF5/1.12.1/lib/libsz.lib

# ------ No machine-specific paths/variables after this  -----

#FORTRANLIB=-I"$(HDF5)/include/static"
FORTRANLIB=-I"$(HDF5)/include/shared"
FSOURCE = dsetexample fileexample
OBJECTS = dsetexample.o fileexample.o

FLAGS   = -c 
LIBSHDF   =  $(HDF5)/lib/hdf5_fortran.lib
#LIBSHDF   =  $(HDF5)/lib/libhdf5_fortran.lib
LIBZZ       = $(LIBZ) $(LIBSZ) -lm


   
#Compiler
FC = ifort
#FCFLAGS = -Od  #disable optimisation
#FCFLAGS = -Od  -C /debug:full /traceback /Qcoarray:shared /Qcoarray-num-images:4
#FCFLAGS = -Ofast  /Qopenmp /Qcoarray:shared 
FCFLAGS = -Ofast  #The aggressive optimizations
#FCFLAGS = -Ofast /Qparallel /Qopenmp /Qopt-report #the auto-parallelizer
#FCFLAGS = -Ofast /Qparallel /Qopenmp #the auto-parallelizer

COMPILE = $(FC) $(FCFLAGS) $(TARGET_ARCH) -c 


objects = converter.obj

converter : $(objects)
    $(FC) -o converter.exe $(FCFLAGS) $(objects) 

objects_h5 = h5_rdwt.obj h5_crtdat.obj

h5_rdwt : $(objects_h5)
    $(FC) -o h5_rdwt.exe $(FCFLAGS) h5_rdwt.obj  $(LIBSHDF) 

h5_crtdat : $(objects_h5)
    $(FC) -o h5_crtdat.exe $(FCFLAGS)  h5_crtdat.obj  $(LIBSHDF) 

h5_rdwt.obj: h5_rdwt.f90
	 $(FC)  $(FORTRANLIB) -c  h5_rdwt.f90 

h5_crtdat.obj: h5_crtdat.f90
	 $(FC)  $(FORTRANLIB) -c h5_crtdat.f90 


compound_complex : compound_complex_fortran2003.f90 
    $(FC) -o compound_complex.exe $(FCFLAGS) $(FORTRANLIB) compound_complex_fortran2003.f90  $(LIBSHDF) 

complex : complex.f90 
    $(FC) -o cmplx.exe $(FCFLAGS) $(FORTRANLIB) complex.f90  $(LIBSHDF) 



.f90.obj: 
    $(COMPILE) $<

clean:
    del *.mod 
    del *.obj
    del *.optrpt
    del *.exe