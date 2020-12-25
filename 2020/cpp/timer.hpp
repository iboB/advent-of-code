#pragma once
#include <chrono>
#include <iostream>

struct timer
{
    using hrc = std::chrono::high_resolution_clock;
    hrc::time_point start;
    timer()
    {
        start = hrc::now();
    }

    ~timer()
    {
        auto end = hrc::now();
        auto us = double(std::chrono::duration_cast<std::chrono::microseconds>(end - start).count());

        std::cout << "Time: " << (us/1'000'000) << " sec\n";
    }
};
