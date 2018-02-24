cmake_minimum_required (VERSION 3.5)
project (parasocks)

# DEBUG mode
# SET(CMAKE_BUILD_TYPE Debug)

# Export compile commands
set( CMAKE_EXPORT_COMPILE_COMMANDS 1 ) 

# C++ 14 standard
set (CMAKE_CXX_STANDARD 14)

#------------------------------------- Boost -----------------------------------------#
# Linux: sudo apt install libboost-all-dev 
# Mac: brew install boost
find_package( Boost 1.58 REQUIRED COMPONENTS atomic chrono context coroutine date_time exception filesystem graph iostreams locale log program_options random regex serialization signals timer system thread wave )
include_directories( ${Boost_INCLUDE_DIR} )

#------------------------------------- OpenSSL ----------------------------------------#
# Linux: sudo apt install libssl-dev
# Mac: brew install openssl
#      echo 'export PATH="/usr/local/opt/openssl/bin:$PATH"' >> ~/.bash_profile
if(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
	set (OPENSSL_ROOT_DIR "/usr/local/opt/openssl" )
	message(STATUS ">>> ${CMAKE_SYSTEM_NAME} uses OpenSSL: ${OPENSSL_ROOT_DIR}")
endif()
find_package( Openssl REQUIRED )
include_directories( ${OPENSSL_INCLUDE_DIR} )

#------------------------------------- BZip2 ----------------------------------------#
find_package( BZip2 REQUIRED)
include_directories( ${BZIP2_INCLUDE_DIR} )

#------------------------------------- ZLIB ----------------------------------------#
find_package( ZLIB REQUIRED)
include_directories( ${ZLIB_INCLUDE_DIR} )

#------------------------------------- CURL ----------------------------------------#
find_package( CURL REQUIRED)
include_directories( ${CURL_INCLUDE_DIR} )

#------------------------------------- project header and lib path -----------------#
# Other external source headers
# include_directories( ${CMAKE_CURRENT_SOURCE_DIR}/external/include )
# link_directories( ${CMAKE_CURRENT_SOURCE_DIR}/external/lib )
include_directories( "common" )

#------------------------------------- Source File List ----------------------------------------#
# set(client_SRC_LIST 1.cpp 2.hpp 3.h 4.cxx ) # add files manually
# Not include subfolder, use file(GLOB srclist "*.cpp" "*.h")
file(GLOB common_SRC_LIST
	"common/*.hpp"
	"common/*.cc"
	"common/*.cpp"
	"common/*.h"
)
file(GLOB_RECURSE client_SRC_LIST
	${common_SRC_LIST} 
	"client/*.cpp" 
	"client/*.cc" 
	"client/*.hpp" 
	"client/*.h"
) 
file(GLOB_RECURSE server_SRC_LIST
	${common_SRC_LIST} 
	"server/*.cpp" 
	"server/*.cc" 
	"server/*.hpp"
	"server/*.h" 
)
#----------------------------------- Client Target -------------------------------------------#

add_executable(client ${client_SRC_LIST})
target_link_libraries (client ${Boost_LIBRARIES} ${OPENSSL_LIBRARIES} ${BZIP2_LIBRARIE} ${ZLIB_LIBRARIE}  ${CURL_LIBRARIE} )

#------------------------------------ Server Target ------------------------------------------#
add_executable(server ${server_SRC_LIST})
target_link_libraries (server ${Boost_LIBRARIES} ${OPENSSL_LIBRARIES} ${BZIP2_LIBRARIE} ${ZLIB_LIBRARIE} ${CURL_LIBRARIE} )

