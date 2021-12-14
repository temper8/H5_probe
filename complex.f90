PROGRAM compound_complex_fortran2003

    USE hdf5
    USE ISO_C_BINDING
    IMPLICIT NONE

    INTEGER, PARAMETER :: NMAX = 10
    INTEGER(HID_T)   :: complex_type_id, dset_id, dspace_id, dset_array_id, dspace_array_id, file_id
    INTEGER(HSIZE_T) :: dims(1)
    INTEGER :: error, i
    integer(HSIZE_T) cmplx_size
    TYPE(C_PTR) :: f_ptr

    TYPE complex_t
        DOUBLE PRECISION re  ! real part
        DOUBLE PRECISION im;  ! imaginary part
    END TYPE complex_t
    
    complex(8) native_cmplx
    complex(8) native_cmplx_array(NMAX)
    type(complex_t) h5_cmplx

    native_cmplx = (0.5, 0.7)
    do i = 1, NMAX
        native_cmplx_array(i) = (0.1, 0.1)*i
    enddo
    cmplx_size = SIZEOF(native_cmplx)
    print *, native_cmplx
    print *, cmplx_size


    !h5_cmplx = native_cmplx
    !print *, h5_cmplx
  ! Initialize FORTRAN interface.
    CALL h5open_f(error)
 ! Create a new file using default properties.
    CALL h5fcreate_f("f_complex.h5", H5F_ACC_TRUNC_F, file_id, error)

    CALL h5tcreate_f(H5T_COMPOUND_F, cmplx_size, complex_type_id, error)

    CALL h5tinsert_f(complex_type_id, 'r', 0, H5T_NATIVE_DOUBLE, error)

    CALL h5tinsert_f(complex_type_id, 'i', cmplx_size/2, H5T_NATIVE_DOUBLE, error)

 
!
    ! Create dataspace
    !
    dims(1) = 1
    CALL h5screate_simple_f(1, dims, dspace_id, error)
    !
    ! Create the dataset.
    !
    CALL H5Dcreate_f(file_id, "cmplx",  complex_type_id, dspace_id, dset_id, error)
    !
    ! Write data to the dataset
    !
    f_ptr = C_LOC(native_cmplx)
    CALL H5Dwrite_f(dset_id, complex_type_id, f_ptr, error)

    ! Create dataspace for array
    !
    dims(1) = NMAX
    CALL h5screate_simple_f(1, dims, dspace_array_id, error)
    !
    ! Create the dataset for array
    !
    CALL H5Dcreate_f(file_id, "array_cmplx",  complex_type_id, dspace_array_id, dset_array_id, error)
    !
    ! Write data to the dataset 
    !
    f_ptr = C_LOC(native_cmplx_array)
    CALL H5Dwrite_f(dset_array_id, complex_type_id, f_ptr, error)
    ! Close up
    CALL h5dclose_f(dset_array_id, error)
    CALL h5sclose_f(dspace_array_id, error)
    CALL h5dclose_f(dset_id, error)
    CALL h5sclose_f(dspace_id, error)
    CALL h5fclose_f(file_id, error)

END PROGRAM compound_complex_fortran2003
