#===============================================================================
#
#   Divide Makefile
#
#-------------------------------------------------------------------------------

#--------------------------
#   Variable definitions
#--------------------------

# Fortran compiler ("gnu", "intel" or "portland")
FORTRAN = gnu

# Debugging ("yes" or "no")
DEBUG = no

# Directories for objects and modules. (No need to change.)
DIR_BINARY = .
DIR_MODULE = .Modules
DIR_OBJECT = .Objects

# Program name (This should hardly change)
PROGRAM_NAME = SFS
PROGRAM_FILE = $(DIR_BINARY)/$(PROGRAM_NAME)

$(info #=======================================================================)
$(info # Compiling $(PROGRAM_NAME) with compiler $(FORTRAN))
$(info #-----------------------------------------------------------------------)
$(info # Usage:                                                                )
$(info #   make <FORTRAN=gnu/intel/portland> <DEBUG=yes/no>                    )
$(info #                                                                       )
$(info # Examples:                                                             )
$(info #   make                 - compile with gnu compiler                    )
$(info #   make FORTAN=portland - compile with intel compiler                  )
$(info #   make DEBUG=yes       - compile with gnu compiler in debug mode      )
$(info #-----------------------------------------------------------------------)

#-------------------------------------------------------------------------------
#   Compiler and linker options
#-------------------------------------------------------------------------------
#   Note: Changes only when support to a new Fortran compiler is added.
#-------------------------------------------------------------------------------
 
# Fortran == gnu
ifeq ($(FORTRAN), gnu)
  FC = gfortran
  ifeq ($(DEBUG),yes)
    OPT_COMP = -J $(DIR_MODULE) -fdefault-real-8 -fdefault-integer-8 -O0 -g
  else
    OPT_COMP = -J $(DIR_MODULE) -fdefault-real-8 -fdefault-integer-8 -O3
  endif 
  OPT_LINK = $(OPT_COMP)
endif 

# Fortran == intel
ifeq ($(FORTRAN), intel)
  FC = ifort
  ifeq ($(DEBUG),yes)
    OPT_COMP = -module $(DIR_MODULE) -r8 -i8 -O0 -g -warn all -check all \
               -debug all -fpe-all=0 -traceback
  else
    OPT_COMP = -module $(DIR_MODULE) -r8 -i8 -O3
  endif
  OPT_LINK = $(OPT_COMP)
endif 

# Fortran == portland
ifeq ($(FORTRAN), portland)
  FC = pgfortran
  ifeq ($(DEBUG),yes)
    OPT_COMP = -module $(DIR_MODULE) -r8 -i8 -O0 -g
  else
    OPT_COMP = -module $(DIR_MODULE) -r8 -i8 -O3
  endif
  OPT_LINK = $(OPT_COMP)
endif 

#------------------------------------------------------
#   List of sources for modules and functions
#------------------------------------------------------
#   Modules' order must obey their dependency 
#   This list should therefore be written "by hand".
#   Note: Modules written in lower case 
#         letters are candidates for deletion.
#------------------------------------------------------

#-------------
#   Modules
#-------------

# Modules in shared directories
SRC_MOD = Globals_Mod.f90	\
          Matrix_Mod.f90	\
          In_Out_Mod.f90	\
          Lin_Alg_Mod.f90	\
          Solvers_Mod.f90	\
          Demo_Mod.f90

#---------------
#   Functions
#---------------

# Sources for all functions are obtained by a shell command
SRC_FUN = $(shell ls -1 *.f90			\
                        | xargs -n1 basename	\
                        | grep -v -i _Mod)

#----------------------------------------------------------------------
#   List of objects generated from the list of modules and functions
#----------------------------------------------------------------------
#   Note: This doesn't need editing.
#----------------------------------------------------------------------
OBJ_MOD = $(SRC_MOD:%.f90=$(DIR_OBJECT)/%.o)
OBJ_FUN = $(SRC_FUN:%.f90=$(DIR_OBJECT)/%.o)
OBJ = $(OBJ_MOD) $(OBJ_FUN)

#-------------------------------------------------------
#   List of modules currently used for target "clean" 
#-------------------------------------------------------
#   Note: This doesn't need editing.
#-------------------------------------------------------
SRC_MOD_LOW = $(shell echo $(SRC_MOD) | tr A-Z a-z)
MOD = $(SRC_MOD_LOW:%.f90=$(DIR_MODULE)/%.mod)

#---------------------------------------------------------
#   Default rule to build Fortran modules and functions
#---------------------------------------------------------
#   Note: This doesn't need editing.
#---------------------------------------------------------

# Modules
$(DIR_OBJECT)/%.o: %.f90 %/*.f90
	@echo FC $<
	@$(FC) $(OPT_COMP) -c -o $@ $<

# Functions
$(DIR_OBJECT)/%.o: %.f90
	@echo FC $<
	@$(FC) $(OPT_COMP) -c -o $@ $<

#-----------------------------------
#   Rule to build main program
#-----------------------------------
#   Note: Should not be modified.
#-----------------------------------
$(PROGRAM_FILE): $(OBJ) 
	@echo Linking "\033[0;32m $(PROGRAM_FILE) \033[0m"
	@$(FC) $(OPT_LINK) -o $(PROGRAM_FILE) $(OBJ)

#--------------------------------------------------------------------
#   Explicit dependencies for modules
#--------------------------------------------------------------------
#   These are automatically generated by:
#   Sources/Utilities/create_external_dependencies_for_makefile.sh
#--------------------------------------------------------------------
include makefile_explicit_dependencies

#---------------------
#   Explicit target.
#---------------------
clean:
	rm -f $(DIR_OBJECT)/*.o $(DIR_MODULE)/*.mod $(PROGRAM_FILE)