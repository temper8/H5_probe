#Compiler
FC = ifort

#FCFLAGS = -Od #disable optimisation
#FCFLAGS = -Ofast #The aggressive optimizations
#FCFLAGS = -Ofast -parallel #the auto-parallelizer
#FCFLAGS = -Ofast -parallel #the auto-parallelizer
#FCFLAGS = -Ofast -parallel -qopenmp -coarray=shared -coarray-num-images=5
FCFLAGS = -Ofast -parallel -qopenmp -coarray=distributed
COMPILE = $(FC) $(FCFLAGS) $(TARGET_ARCH) -c

MKLFLAGS =  ${MKLROOT}/lib/intel64/libmkl_blas95_ilp64.a ${MKLROOT}/lib/intel64/libmkl_lapack95_ilp64.a -Wl,--start-group \
 ${MKLROOT}/lib/intel64/libmkl_intel_ilp64.a \
 ${MKLROOT}/lib/intel64/libmkl_sequential.a \
 ${MKLROOT}/lib/intel64/libmkl_core.a -Wl,--end-group -lpthread -lm -ldl

MKL_INCLUDE = -I${MKLROOT}/include/intel64/ilp64 -i8  -I"${MKLROOT}/include" 
COMPILE_MKL = $(FC) $(FCFLAGS) $(TARGET_ARCH) $(MKL_INCLUDE)-c

objects = Types.o Const.o ErrorMan.o LowLev.o utils.o MKL_wrapper.o gauset.o StringOp.o grill_functions.o ZimProcessing.o grill.o main.o

grill : $(objects)
	$(FC) -parallel -qopenmp -o pgrill.exe $(FCFLAGS) $(objects)  $(MKLFLAGS)

MKL_wrapper.mod MKL_wrapper.o: MKL_wrapper.f90
	$(COMPILE_MKL) MKL_wrapper.f90 

%.o %.mod: %.f90 
	$(COMPILE) $<

clean:
	-rm -f *.o *.mod *.exe
	