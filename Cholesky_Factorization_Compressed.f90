!==============================================================================!
  subroutine Cholesky_Factorization_Compressed(f, a)
!------------------------------------------------------------------------------!
!   Computes full Cholesky decomposition.  This is promising!                  !
!------------------------------------------------------------------------------!
!----------------------------------[Modules]-----------------------------------!
  use Matrix_Mod
!------------------------------------------------------------------------------!
  implicit none
!------------------------------------------------------------------------------!
  type(Matrix)         :: f
  real, dimension(:,:) :: a
!------------------------------------------------------------------------------!
  integer :: i, j, k, m, n, k_m, k_i, m_j
  real    :: sum1, sum2
  real, allocatable :: work(:)
!==============================================================================!

  n = size(a,1)  ! some checks would be possible
  allocate( work(n) ); work = 0.0

  do k=1,n

    !--------------------!
    !   Diagonal entry   !
    !--------------------!
    sum1 = a(k,k)
    do k_m = f % row(k), f % dia(k) - 1  
      sum1 = sum1 - f % val(k_m)**2.0    
    end do
    f % val( f % dia(k) ) = sqrt(sum1)

    !------------------------!
    !   Non-diagonal entry   !
    !------------------------!
    do k_i = f % dia(k) + 1, f % row(k+1) -1 
      i = f % col(k_i)
      sum2 = a(i,k)  ! a(i,k) should be the same as a(k,i), right?

      do k_m = f % row(k), f % dia(k) - 1
        m = f % col(k_m)
 
        ! De-compress the row
        do m_j = f % row(m), f % row(m+1) - 1
          j = f % col(m_j)
          work(j) = f % val(m_j)
        end do      

        sum2 = sum2 - work(i)*work(k)

        ! set the row back to zero
        work = 0.0
      end do

      f % val(k_i) = sum2 / f % val(f % dia(k))
      f % val(f % mir(k_i)) = f % val(k_i) 
    end do
  end do

  end subroutine Cholesky_Factorization_Compressed
