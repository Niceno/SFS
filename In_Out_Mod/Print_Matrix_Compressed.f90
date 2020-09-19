!==============================================================================!
  subroutine In_Out_Mod_Print_Matrix_Compressed(message, c_matrix)
!------------------------------------------------------------------------------!
!   Prints compressed matrix out.                                              !
!------------------------------------------------------------------------------!
  implicit none
!---------------------------------[Arguments]----------------------------------!
  character(len=*) :: message
  type(Matrix)     :: c_matrix
!-----------------------------------[Locals]-----------------------------------!
  integer :: row, col, pos  ! row used to be "i", col used to be "j"
  logical :: found
!==============================================================================!

  if(c_matrix % n > 64) return

  write(*,*) message

  do row = 1, c_matrix % n
    do col = 1, c_matrix % n
      found = .false.

      ! Look for position row, col in the compressed
      ! c_matrix and print if you have found it
      do pos = c_matrix % row(row), c_matrix % row(row + 1) - 1
        if( c_matrix % col(pos) == col ) then
          write(*,"(f6.1)",advance="no") c_matrix % val(pos)
          found = .true.
        end if
      end do

      ! If you haven't found it, print something else
      if( .not. found ) then
        write(*,"(a6)",advance="no") "   .   "
      end if
    end do
    write(*,*) ""
  end do

  end subroutine