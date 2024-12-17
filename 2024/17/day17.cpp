#include "../cpp/timer.hpp"
#include <fstream>
#include <iostream>
#include <vector>
#include <array>
#include <string_view>
#include <thread>
#include <atomic>

int main() {
    std::ifstream file(INPUT_PATH "/input.txt");
    std::string line;

    std::array<uint64_t, 3> regs = {0, 0, 0};
    for (int i = 0; i < 3; ++i) {
        std::getline(file, line);
        line = line.substr(line.rfind(' ') + 1);
        regs[i] = std::stoull(line);
    }
    std::getline(file, line); // empty

    std::getline(file, line);

    std::vector<int> ops;

    std::string_view sv(line);
    sv.remove_prefix(sv.find(' ') + 1);
    while (!sv.empty()) {
        auto comma = sv.find(',');
        if (comma == std::string_view::npos) {
            ops.push_back(std::stoi(std::string(sv)));
            break;
        }
        ops.push_back(std::stoi(std::string(sv.substr(0, comma))));
        sv.remove_prefix(comma + 1);
    }

    static constexpr uint64_t THREADS = 8;
    std::vector<int> out[THREADS];

    auto calc = [&](uint64_t i, auto regs) {
        out[i].clear();

        auto combo = [&](int n) {
            if (n < 4) return uint64_t(n);
            return regs[n - 4];
        };

        auto& [a, b, c] = regs;
        auto ip = ops.cbegin();
        while (ip < ops.end()) {
            auto code = *ip++;
            auto op = *ip++;

            switch (code) {
            case 0: a /= 1ull << combo(op); break;
            case 1: b ^= op; break;
            case 2: b = combo(op) & 7; break;
            case 3: if (a) ip = ops.cbegin() + op; break;
            case 4: b ^= c; break;
            case 5: out[i].push_back(combo(op) & 7); break;
            case 6: b = a / (1ull << combo(op)); break;
            case 7: c = a / (1ull << combo(op)); break;
            }
        }
    };

    calc(0, regs);

    for (auto it = out[0].cbegin(); it != out[0].cend(); ++it) {
        std::cout << *it;
        if (it + 1 != out[0].cend()) std::cout << ',';
    }
    std::cout << std::endl;

    timer t;

    std::atomic_flag found = ATOMIC_FLAG_INIT;
    auto search = [&](uint64_t i) {
        auto mregs = regs;
        auto a = (1ull<<47) + i;
        while (true) {
            if (found.test(std::memory_order_relaxed)) return;
            mregs[0] = a;
            calc(i, mregs);
            if (out[i] == ops) {
                std::cout << a << std::endl;
                found.test_and_set(std::memory_order_relaxed);
            }
            a += THREADS;
            static constexpr uint64_t log = 10'000'000;
            if (a % log == 0) {
                std::cout << a / log << std::endl;
            }
        }
    };

    std::vector<std::thread> threads;
    for (uint64_t i = 1; i < THREADS; ++i) {
        threads.push_back(std::thread(search, i));
    }
    search(0);

    for (auto& t : threads) t.join();

    return 0;
}