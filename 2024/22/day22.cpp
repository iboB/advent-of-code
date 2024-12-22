// terrible brute-force which runs for 200 seconds
// ... but it was very fast to write :)
#include "../cpp/timer.hpp"
#include <iostream>
#include <fstream>
#include <vector>
#include <string>

using vec = std::vector<int64_t>;

vec gen(int64_t num, size_t i) {
    vec res;
    res.reserve(i + 1);
    res.push_back(num);
    static constexpr int64_t MOD = 16777216;
    for (size_t j = 0; j < i; ++j) {
        num ^= num * 64;
        num %= MOD;
        num ^= num / 32;
        num %= MOD;
        num ^= num * 2048;
        num %= MOD;
        res.push_back(num);
    }
    return res;
}

int main() {
    static constexpr size_t SIZE = 2000;

    vec numbers;

    std::ifstream file(INPUT_PATH "/input.txt");
    std::string line;

    while (std::getline(file, line)) {
        numbers.push_back(std::stoi(line));
    }

    std::vector<std::pair<vec, std::string>> gens;
    for (auto& n : numbers) {
        gens.push_back({gen(n, SIZE), {}});
    }

    int64_t sum = 0;
    for (auto& g : gens) {
        sum += g.first.back();
    }
    std::cout << sum << std::endl;

    static constexpr char CC = 'n';

    for (auto& g : gens) {
        for (auto& n : g.first) {
            n %= 10;
        }
        g.second.reserve(SIZE);
        for (size_t i = 0; i < SIZE; ++i) {
            g.second.push_back(char(CC + g.first[i + 1] - g.first[i]));
        }
    }

    timer t;

    int max = 0;

    for (int a = -9; a < 10; ++a) {
        for (int b = -9; b < 10; ++b) {
            //std::cout << a << " " << b << std::endl;
            for (int c = -9; c < 10; ++c) {
                for (int d = -9; d < 10; ++d) {
                    int s = a + b + c + d;
                    if (s < -9 || s > 9) continue;

                    std::string f = {char(a + CC), char(b + CC), char(c + CC), char(d + CC)};
                    int sum = 0;

                    for (auto& g : gens) {
                        auto pos = g.second.find(f);
                        if (pos == std::string::npos) continue;
                        sum += g.first[pos + f.size()];
                    }

                    if (sum > max) max = sum;
                }
            }
        }
    }

    std::cout << max << std::endl;

    return 0;
}
