!==============================================================================!
  subroutine Prec_Form(N, A, D) 
!------------------------------------------------------------------------------!
! Forms preconditioning matrix "D" from provided matrix "A".                   !
!------------------------------------------------------------------------------!
!----------------------------------[Modules]-----------------------------------!
  use Matrix_Mod
!------------------------------------------------------------------------------!
  implicit none
!---------------------------------[Arguments]----------------------------------!
  integer      :: N
  type(Matrix) :: A
  type(Matrix) :: D    
!-----------------------------------[Locals]-----------------------------------!
  real     :: sum1
  integer  :: i, j, k
!==============================================================================!
                 
  do i = 1,N
    sum1 = A % val(A % dia(i))       ! take diaginal entry   
    do j = A % row(i), A % dia(i)-1  ! only lower traingular
      k = A % col(j)                    
      sum1 = sum1 - D % val(D % dia(k)) * A % val(j) * A % val(j)  
    end do

    ! This is only the diagonal from LDL decomposition
    D % val(D % dia(i)) = 1.0 / sum1
  end do

  end subroutine Prec_Form