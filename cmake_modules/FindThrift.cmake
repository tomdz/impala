# - Find Thrift (a cross platform RPC lib/tool)
# This module defines
#  Thrift_VERSION, version string of ant if found
#  Thrift_INCLUDE_DIR, where to find Thrift headers
#  Thrift_CONTRIB_DIR, where contrib thrift files (e.g. fb303.thrift) are installed
#  Thrift_LIBS, Thrift libraries
#  Thrift_FOUND, If false, do not try to use ant

# prefer the thrift version supplied in THRIFT_HOME
set(Thrift_HOME $ENV{THRIFT_HOME})
IF (NOT Thrift_HOME)
  set(Thrift_HOME ${CMAKE_SOURCE_DIR}/thirdparty/thrift-$ENV{IMPALA_THRIFT_VERSION}/build)
ENDIF (NOT Thrift_HOME)

message(STATUS "${Thrift_HOME}")
find_path(Thrift_INCLUDE_DIR Thrift.h HINTS
  ${Thrift_HOME}/include/thrift
  /usr/local/include/thrift
  /opt/local/include/thrift
)

# prefer the thrift contrib version supplied in THRIFT_CONTRIB_DIR
set(Thrift_CONTRIB_DIR $ENV{THRIFT_CONTRIB_DIR})
IF (NOT Thrift_CONTRIB_DIR)
  set(Thrift_CONTRIB_DIR ${CMAKE_SOURCE_DIR}/thirdparty/thrift-$ENV{IMPALA_THRIFT_VERSION}/build)
ENDIF (NOT Thrift_CONTRIB_DIR)

set(Thrift_LIB_PATHS
  ${Thrift_HOME}/lib
  /usr/local/lib
  /opt/local/lib)

find_path(Thrift_STATIC_LIB_PATH libthrift.a PATHS ${Thrift_LIB_PATHS})

# prefer the thrift version supplied in THRIFT_HOME
find_library(Thrift_LIB NAMES thrift HINTS ${Thrift_LIB_PATHS})

find_path(THRIFT_COMPILER_PATH NAMES thrift PATHS
  ${Thrift_HOME}/bin
  /usr/local/bin
  /usr/bin
)

if (Thrift_LIB)
  set(Thrift_FOUND TRUE)
  set(Thrift_LIBS ${Thrift_LIB})
  set(Thrift_STATIC_LIB ${Thrift_STATIC_LIB_PATH}/libthrift.a)
  set(Thrift_NB_STATIC_LIB ${Thrift_STATIC_LIB_PATH}/libthriftnb.a)
  set(Thrift_COMPILER ${THRIFT_COMPILER_PATH}/thrift)
  exec_program(${Thrift_COMPILER}
    ARGS -version OUTPUT_VARIABLE Thrift_VERSION RETURN_VALUE Thrift_RETURN)
else ()
  set(Thrift_FOUND FALSE)
endif ()

if (Thrift_FOUND)
  if (NOT Thrift_FIND_QUIETLY)
    message(STATUS "${Thrift_VERSION}")
  endif ()
else ()
  message(STATUS "Thrift compiler/libraries NOT found. "
          "Thrift support will be disabled (${Thrift_RETURN}, "
          "${Thrift_INCLUDE_DIR}, ${Thrift_LIB})")
endif ()


mark_as_advanced(
  Thrift_LIB
  Thrift_COMPILER
  Thrift_INCLUDE_DIR
)
