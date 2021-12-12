module ZimProcessing

    type ZimData
        real(8)::scale_im
        integer file_number
        integer(4)::ierr, kymax, kzmax
        complex(8), allocatable, dimension(:,:,:) :: z
        complex(8), allocatable, dimension(:,:,:,:,:) :: ssyy,ssyz,sszy,sszz
    end type
    contains 
    function ReadZim(file_number)
        implicit none
        Type(ZimData) ReadZim
        integer un
        integer file_number
        character(len=3)::number
        character(len=20)::filename
        ReadZim%file_number = file_number
        un = 20 + file_number
        write(number,'(i3.3)') file_number
        filename='data/zim'//number//'.dat'
        open(un,file=filename,form='unformatted',status='old',iostat=ReadZim%ierr)
        if (ReadZim%ierr /= 0) return
        write(6,'(a)') ' Reading '//filename//'... '
        read(un) ReadZim%kymax,ReadZim%kzmax
        print *, ReadZim%kymax,ReadZim%kzmax
        allocate(ReadZim%z(5,ReadZim%kymax,ReadZim%kzmax),stat=ReadZim%ierr)
        if (ReadZim%ierr /= 0) print *, 'Failed to allocate z array'
        read(un) ReadZim%z
        read(un,iostat=ReadZim%ierr) ReadZim%scale_im
        close(un)
        return
    end 

end module ZimProcessing
! **********************************************************************
program converter
    use ZimProcessing
    implicit none
    Type(ZimData), allocatable:: zim(:)
    integer(8)                :: key, num_of_zim, stat
    character(len=32)         :: arg1, arg2
    integer hostnm, status
    character(8) name
    status = hostnm( name )
    write(*,*) 'host name = ', name
    num_of_zim = 20
    allocate(zim(num_of_zim))
    zim(1) = ReadZim(1)

end program converter