###### Link Compile Path ##############

# TESTING: ASSUMES FOLLOWING VARIABLES FROM chinx.sh is defined
#set(CROSS_SYS_ROOT_PATH ${CROSS_ENVIRON_ROOT}) 
#set(ARM_SYS_ROOT_PATH ${TARGET_ROOT}) 

set(TARGET_STD_USR_PATH ${TARGET_ROOT}/usr)
set(TARGET_STD_LIB_PATH ${TARGET_ROOT}/usr/lib)
set(TARGET_SYS_LIB_PATH ${TARGET_ROOT}/lib)
set(TARGET_STD_INC_PATH ${TARGET_ROOT}/usr/include)

set(ARCHITECTURE $ENV{ARCHITECTURE})
set(CROSS_ENVIRONMENT_ROOT $ENV{CROSS_ENVIRONMENT_ROOT})
#set(GCC_MACHINE_DUMP ${ARCHITECTURE})
set(CMAKE_SYSTEM_NAME ${ARCHITECTURE})

# THIS THING IS DANGEROUS, READ UP#
#set(CMAKE_SYSROOT ${TARGET_ROOT})
#By default the CMAKE_FIND_ROOT_PATH is empty.
#set(CMAKE_FIND_ROOT_PATH ${TARGET_ROOT} ${CROSS_ENVIRONMENT_ROOT}) 

# MIGHT NOT NEED THIS, CMAKE_PREFIX_PATH might be enough
message( " TARGET ROOT IS is $ENV{TARGET_ROOT}" )
set(CMAKE_FIND_ROOT_PATH $ENV{TARGET_ROOT}) 
message( "CMAKE_FIND_ROOT_PATH is ${CMAKE_FIND_ROOT_PATH}" )

# CMAKE_PREFIX_PATH search a specified dir for lib/, /include/, bin/
# list of paths where the following cmake functions will be used
# - find_package()
# - find_program()
# - find_library()
# - find_file()
# - find_path()

                  ##### IMPORTANT ####  
# CMAKE_PREFIX_PATX ony search /lib, /include, NOT usr/lib usr/include
set(CMAKE_PREFIX_PATH $ENV{TARGET_ROOT}/usr) # add more locations with semiconlon separated list

# Here one can add further paths to search for include,lib speficif folders separatly 
#set(CMAKE_INCLUDE_PATH  ${TARGET_STD_INC_PATH} ; ${TARGET_STD_INC_PATH}/${GCC_MACHINE_DUMP} )
#set(CMAKE_LIBRARY_PATH  ${TARGET_SYS_LIB_PATH} ; ${TARGET_STD_LIB_PATH}/${GCC_MACHINE_DUMP} ; ${TARGET_STD_LIB_PATH} ; ${TARGET_SYS_LIB_PATH}/${GCC_MACHINE_DUMP})
#set(CMAKE_PROGRAM_PATH  ${TARGET_ROOT}/usr/bin})

# WARNING!
# DURING CONFIGURATION, CMAKE WILL TEST THE SELECTED COMPILER.
# DURING CROSSCOMPILING, THESE TEST WILL FAIL(THE LINKER) DUE TOO TRYNIC TO RUN
# THE DYNAMIC LINKER. 
# TO OPTIONS:
# -  FORCE STATIC LIBRARY INSTEAD.
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")
# - JUMP OVER TRY_COMPILE USING THE CMAKE_FORCE_LANGUAGE (UGLY BUT WORKS)

##### CROSS-COMPILER BINARIES
set(CROSS_ARM_BIN      "${CROSS_ENVIRONMENT_ROOT}/bin") 
set(CMAKE_C_COMPILER   "${CROSS_ARM_BIN}/${ARCHITECTURE}-gcc")
set(CMAKE_CXX_COMPILER "${CROSS_ARM_BIN}/${ARCHITECTURE}-g++")
set(CMAKE_AR           "${CROSS_ARM_BIN}/${ARCHITECTURE}-ar")
set(CMAKE_RANLIB       "${CROSS_ARM_BIN}/${ARCHITECTURE}-ranlib")
set(CMAKE_LINKER       "${CROSS_ARM_BIN}/${ARCHITECTURE}-ld")

########### Macro to Limit Find path in host and targert ###################
# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

option(TARGET_ROOT_ONLY "Search only for lib, include, package in CMAKE_FIND_ROOT_DIR" ON)
# for libraries and headers in the target directories
if (TARGET_ROOT_ONLY)
    set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
    set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
    set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
endif(TARGET_ROOT_ONLY)



#set(CMAKE_INSTALL_PREFIX ${TARGET_ROOT}/usr/local/OpenCV ) ## install Path

