cmake_minimum_required(VERSION 3.14)

project(aoc2016)

include(./get_cpm.cmake)

CPMAddPackage(gh:iboB/itlib@1.10.3)

set(CMAKE_CXX_STANDARD 20)

macro(add_day d)
    get_filename_component(dir ${CMAKE_CURRENT_SOURCE_DIR}/../${d} ABSOLUTE)
    add_executable(day${d} "${dir}/day${d}.cpp")
    target_compile_definitions(day${d} PRIVATE -DINPUT_PATH="${dir}")
    target_link_libraries(day${d} PRIVATE itlib::itlib)
endmacro()

add_day(08)
