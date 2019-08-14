###### Link Compile Path ##############
set(CROSS_SYS_ROOT_PATH /home/jackal/arm64cross/aarch64-unknown-linux-gnu) 
set(ARM_SYS_ROOT_PATH /home/jackal/arm64cross/aarch64-unknown-linux-gnu/aarch64-unknown-linux-gnu) 

set(ARM_STD_USR_PATH ${ARM_SYS_ROOT_PATH}/usr)
set(ARM_STD_LIB_PATH ${ARM_SYS_ROOT_PATH}/usr/lib)
set(ARM_SYS_LIB_PATH ${ARM_SYS_ROOT_PATH}/lib)
set(ARM_STD_INC_PATH ${ARM_SYS_ROOT_PATH}/usr/include)


set(GCC_MACHINE_DUMP aarch64-unknown-linux-gnu)
set(CMAKE_SYSTEM_NAME aarch64-unknown-linux-gnu)

# THIS THING IS DANGEROUS, READ UP#
#set(CMAKE_SYSROOT ${ARM_SYS_ROOT_PATH})
##searchs in X/lib and X/usr/lib
set(CMAKE_FIND_ROOT_PATH ${ARM_SYS_ROOT_PATH} ${CROSS_SYS_ROOT_PATH}) 

set(CMAKE_INCLUDE_PATH  ${ARM_STD_INC_PATH} ; ${ARM_STD_INC_PATH}/${GCC_MACHINE_DUMP} )
set(CMAKE_LIBRARY_PATH  ${ARM_SYS_LIB_PATH} ; ${ARM_STD_LIB_PATH}/${GCC_MACHINE_DUMP} ; ${ARM_STD_LIB_PATH} ; ${ARM_SYS_LIB_PATH}/${GCC_MACHINE_DUMP})
set(CMAKE_PROGRAM_PATH  ${ARM_SYS_ROOT_PATH}/usr/bin})

# AVOID DYNAMIC LIBRARY TEST FOR LINKER, WILL FAIL IF NOT.
# CMAKE_FORCE_"LANGUAGE"_COMPILER WILL OVERRUN, BUT UGLY
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")

#set(CMAKE_LIBRARY_PATH "${ARM_SYS_ROOT_PATH}/lib")

##### CROSS-COMPILER BINARIES
set(CROSS_ARM_BIN      "${CROSS_SYS_ROOT_PATH}/bin") 
set(CMAKE_C_COMPILER   "${CROSS_ARM_BIN}/${CMAKE_SYSTEM_NAME}-gcc")
set(CMAKE_CXX_COMPILER "${CROSS_ARM_BIN}/${CMAKE_SYSTEM_NAME}-g++")
set(CMAKE_AR           "${CROSS_ARM_BIN}/${CMAKE_SYSTEM_NAME}-ar")
set(CMAKE_RANLIB       "${CROSS_ARM_BIN}/${CMAKE_SYSTEM_NAME}-ranlib")
set(CMAKE_LINKER       "${CROSS_ARM_BIN}/${CMAKE_SYSTEM_NAME}-ld")

########### Macro to Limit Find path in host and targert ###################
# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)



#set(CMAKE_INSTALL_PREFIX ${ARM_SYS_ROOT_PATH}/usr/local/OpenCV ) ## install Path
