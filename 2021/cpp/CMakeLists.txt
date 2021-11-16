cmake_minimum_required(VERSION 3.14)

project(aoc2021)

set(CMAKE_CXX_STANDARD 17)

macro(add_day d)
    get_filename_component(dir ${CMAKE_CURRENT_SOURCE_DIR}/../${d} ABSOLUTE)
    add_executable(day${d} "${dir}/day${d}.cpp")
    target_compile_definitions(day${d} PRIVATE -DINPUT_PATH="${dir}")
endmacro()
