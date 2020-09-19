!==============================================================================!
  subroutine Matrix_Mod_Expand(a, c)
!------------------------------------------------------------------------------!
  implicit none
!---------------------------------[Arguments]----------------------------------!
  real, allocatable :: a(:,:)
  type(Matrix_Type) :: c
!-----------------------------------[Locals]-----------------------------------!
  integer :: row, col  ! row used to be "i", col used to be "j"
  integer :: n, pos
!==============================================================================!

  n = c % n

  !---------------------!
  !   Allocate memory   !
  !---------------------!
  allocate (a(n,n))
  a = 0.0

  !------------------------------!
  !   Form the expanded matrix   !
  !------------------------------!
  pos = 1
  do row = 1, n                                  ! browse through rows
    do pos = c % row(row), c % row(row + 1) - 1  ! brows through columns
      col = c % col(pos)                         ! take the real column number
      a(row, col) = c % val(pos)
    end do
  end do

  end subroutine
