cmake_minimum_required(VERSION 3.24)

project(aoc2024)

include(./get_cpm.cmake)

CPMAddPackage(gh:iboB/itlib@1.11.4)

set(CMAKE_CXX_STANDARD 23)

macro(add_day d)
    get_filename_component(dir ${CMAKE_CURRENT_SOURCE_DIR}/../${d} ABSOLUTE)
    add_executable(day${d} "${dir}/day${d}.cpp")
    target_compile_definitions(day${d} PRIVATE -DINPUT_PATH="${dir}")
    target_link_libraries(day${d} PRIVATE itlib::itlib)
endmacro()

add_day(16)
add_day(17)
add_day(22)
