!==============================================================================!
  module In_Out_Mod
!------------------------------------------------------------------------------!
!----------------------------------[Modules]-----------------------------------!
  use Matrix_Mod
!------------------------------------------------------------------------------!
  implicit none
!------------------------------------------------------------------------------!
!   A suite of routines for input and output                                   !
!==============================================================================!

  contains

  include 'In_Out_Mod/Load_Linear_System.f90'
  include 'In_Out_Mod/Print_Matrix_Compressed.f90'
  include 'In_Out_Mod/Print_Matrix.f90'
  include 'In_Out_Mod/Print_Vector.f90'

  end module