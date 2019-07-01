###### Link Compile Path ##############
set(ARM_SYS_ROOT_PATH /home/jackal/arm64cross/aarch64-unknown-linux-gnu/aarch64-unknown-linux-gnu) 

set(ARM_STD_USR_PATH ${ARM_SYS_ROOT_PATH}/usr)
set(ARM_STD_LIB_PATH ${ARM_SYS_ROOT_PATH}/usr/lib)
set(ARM_SYS_LIB_PATH ${ARM_SYS_ROOT_PATH}/lib)
set(ARM_STD_INC_PATH ${ARM_SYS_ROOT_PATH}/usr/include)


set(GCC_MACHINE_DUMP aarch64-unknown-linux-gnu)
set(CMAKE_SYSTEM_NAME aarch64-unknown-linux-gnu)

set(CMAKE_SYSROOT ${ARM_SYS_ROOT_PATH})
set(CMAKE_FIND_ROOT_PATH ${ARM_SYS_ROOT_PATH}) ##searchs in X/lib and X/usr/lib
set(CMAKE_INCLUDE_PATH  ${ARM_STD_INC_PATH} ; ${ARM_STD_INC_PATH}/${GCC_MACHINE_DUMP} )
set(CMAKE_LIBRARY_PATH  ${ARM_SYS_LIB_PATH} ; ${ARM_STD_LIB_PATH}/${GCC_MACHINE_DUMP} ; ${ARM_STD_LIB_PATH} ; ${ARM_SYS_LIB_PATH}/${GCC_MACHINE_DUMP})
set(CMAKE_PROGRAM_PATH  ${ARM_SYS_ROOT_PATH}/usr/bin})

##### CROSS-COMPILER BINARIES
#set(CROSS_ARM_BIN /home/jackal/arm64cross/aarch64-unknown-linux-gnu/bin) 
#set(CMAKE_C_COMPILER "${CROSS_ARM_BIN}/${CMAKE_SYSTEM_NAME}-gcc")
#set(CMAKE_C_COMPILER /home/jackal/arm64cross/aarch64-unknown-linux-gnu/bin/aarch64-unknown-linux-gnu-gcc)
#set(CMAKE_CXX_COMPILER "${CROSS_ARM_BIN}/${CMAKE_SYSTEM_NAME}-g++")
#set(CMAKE_CXX_COMPILER /home/jackal/arm64cross/aarch64-unknown-linux-gnu/bin/aarch64-unknown-linux-gnu-g++)
#set(CMAKE_AR "/usr/gcc-linaro-arm-linux-gnueabihf-4.7/bin/arm-linux-gnueabihf-ar")
#set(CMAKE_AR /home/jackal/arm64cross/aarch64-unknown-linux-gnu/bin/aarch64-unknown-linux-gnu-ar)
#set(CMAKE_RANLIB "/usr/gcc-linaro-arm-linux-gnueabihf-4.7/bin/arm-linux-gnueabihf-ranlib")
#set(CMAKE_RANLIB /home/jackal/arm64cross/aarch64-unknown-linux-gnu/bin/aarch64-unknown-linux-gnu-ranlib)
#set(CMAKE_LINKER "/usr/gcc-linaro-arm-linux-gnueabihf-4.7/bin/arm-linux-gnueabihf-ld")
#set(CMAKE_LINKER /home/jackal/arm64cross/aarch64-unknown-linux-gnu/bin/aarch64-unknown-linux-gnu-ld)

########### Macro to Limit Find path in host and targert ###################
# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
#set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
#set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
#set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

include(CMakeForceCompiler)
CMAKE_FORCE_C_COMPILER(aarch64-unknown-linux-gnu-gcc GNU)
CMAKE_FORCE_CXX_COMPILER(aarch64-unknown-linux-gnu-g++ GNU)


#set(CMAKE_INSTALL_PREFIX ${ARM_SYS_ROOT_PATH}/usr/local/OpenCV ) ## install Path

