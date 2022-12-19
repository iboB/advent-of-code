#include <iostream>
#include <fstream>
#include <vector>
#include <array>
#include <regex>
#include <algorithm>
#include "../cpp/timer.hpp"

using namespace std;

using Blueprint = std::array<int, 7>;

std::vector<Blueprint> readInput() {
    std::vector<Blueprint> ret;

    ifstream fin(INPUT_PATH"/input.txt");
    while (!fin.eof()) {
        std::string line;
        std::getline(fin, line);
        if (line.empty()) break;
        auto& cur = ret.emplace_back();
        auto n = cur.begin();
        std::regex re("\\d+");
        auto beg = std::sregex_iterator(line.begin(), line.end(), re);
        std::sregex_iterator end;
        for (auto i = beg; i != end; ++i) {
            *n++ = stoi(i->str());
        }
    }

    return ret;
}

struct Vector : public std::array<int, 4> {
    Vector() = default;
    Vector(int a, int b, int c, int d) {
        at(0) = a; at(1) = b; at(2) = c; at(3) = d;
    }
    friend Vector operator+(const Vector& a, const Vector& b) {
        Vector ret;
        for (int i = 0; i < 4; ++i) { ret[i] = a[i] + b[i]; }
        return ret;
    }
    friend Vector operator-(const Vector& a, const Vector& b) {
        Vector ret;
        for (int i = 0; i < 4; ++i) { ret[i] = a[i] - b[i]; }
        return ret;
    }
    bool neg() {
        for (auto i : *this) {
            if (i < 0) return true;
        }
        return false;
    }
};

struct Record {
    Vector bots;
    Vector resources;
    int hodl;
    friend auto operator<=>(const Record&, const Record&) = default;
};

int solve(int days, const Blueprint& bp) {
    const Vector maxBot = {
        std::max(bp[1], std::max(bp[2], std::max(bp[3], bp[5]))),
        bp[4],
        bp[6],
        1'000'000
    };

    const std::array price = {
        Vector{bp[1], 0, 0, 0},
        Vector{bp[2], 0, 0, 0},
        Vector{bp[3], bp[4], 0, 0},
        Vector{bp[5], 0, bp[6], 0},
    };

    const std::array buy = {
        Vector{1, 0, 0, 0},
        Vector{0, 1, 0, 0},
        Vector{0, 0, 1, 0},
        Vector{0, 0, 0, 1},
    };

    std::vector<Record> prevDay = {{Vector{1, 0, 0, 0}, Vector{0, 0, 0, 0}, -1}};
    std::vector<Record> nextDay;
    for (int d = 1; d <= days; ++d) {
        nextDay.clear();
        for (const auto& r : prevDay) {
            if (r.hodl >= 0) {
                auto nres = r.resources - price[r.hodl];
                if (nres.neg()) {
                    nextDay.push_back({r.bots, r.resources + r.bots, r.hodl});
                }
                else {
                    nextDay.push_back({r.bots + buy[r.hodl], nres + r.bots, -1});
                }
            }
            else {
                const Vector canHodl = {1, 1, r.bots[1] > 0, r.bots[2] > 0};
                for (int i = 0; i < 4; ++i) {
                    if (!canHodl[i]) continue;
                    if (r.bots[i] >= maxBot[i]) continue;
                    auto nres = r.resources - price[i];
                    if (nres.neg()) {
                        nextDay.push_back({r.bots, r.resources + r.bots, i});
                    }
                    else {
                        nextDay.push_back({r.bots + buy[i], nres + r.bots, -1});
                    }
                }
            }
        }
        std::sort(nextDay.begin(), nextDay.end());
        auto ne = std::unique(nextDay.begin(), nextDay.end());
        nextDay.erase(ne, nextDay.end());
        prevDay.swap(nextDay);
        cout << d << ": " << prevDay.size() << "\n";
    }

    int maxG = 0;
    for (auto& r : prevDay) {
        if (r.resources[3] > maxG) {
            maxG = r.resources[3];
        }
    }
    return maxG;
}

int main() {
    const auto blueprints = readInput();

    // a
    {
        timer t;
        int sum = 0;
        for (auto& bp : blueprints) {
            sum += bp[0] * solve(24, bp);
        }
        cout << sum << "\n";
    }

    // b
    {
        timer t;
        int prod = 1;
        for (int i = 0; i < 3; ++i) {
            if (i == blueprints.size()) break;
            prod *= solve(32, blueprints[i]);
        }
        cout << prod << "\n";
    }
}
