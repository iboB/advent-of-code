#include <fstream>
#include <iostream>
#include <vector>
#include <string>
#include <cassert>

#include "../cpp/timer.hpp"

// silly brute-force dijkstra for 15 seconds
// A* would've been better but ain't nobody got time for this

using namespace std;

struct Map {
    int w, h;
    vector<vector<int>> risk;

    void dbg_print() {
        for (auto& row : risk) {
            for (auto i : row) printf("%d", i);
            cout << '\n';
        }
    }

    // work
    vector<vector<int>> best;

    template <typename F>
    void eachN(int x, int y, F f) {
        if (x > 0) f(x - 1, y);
        if (x < w - 1) f(x + 1, y);
        if (y > 0) f(x, y - 1);
        if (y < h - 1) f(x, y + 1);
    }

    void r(int x, int y, int cur) {
        cur += risk[y][x];
        if (cur >= best[y][x]) return;
        best[y][x] = cur;
        eachN(x, y, [&](int nx, int ny) {
            r(nx, ny, cur);
        });
    }

    static constexpr int BIG = 1'000'000;

    int solve() {
        // find one (bad) path
        int badPath = risk[0][0];
        for (int y = 1; y < h; ++y) {
            badPath += risk[y][0];
        }
        for (int x = 1; x < w; ++x) {
            badPath += risk[h-1][x];
        }

        best.clear();
        best.resize(risk.size());
        for (auto& row : best) {
            row.resize(risk[0].size());
        }

        // fill best values with worst manhattan distance
        for (int y = 0; y < h; ++y) {
            for (int x = 0; x < w; ++x) {
                best[y][x] = badPath - (w - x - 1 + h - y - 1);
            }
        }

        r(0, 0, 0);

        return best.back().back() - risk[0][0];
    }
};

Map readInput() {
    Map map;
    map.risk.reserve(200);
    ifstream fin(INPUT_PATH"/input.txt");

    while (!fin.eof()) {
        std::string row;
        std::getline(fin, row);
        if (row.empty()) break;
        std::vector<int> irow;
        irow.reserve(row.size());
        for (auto c : row) {
            irow.push_back(c - '0');
        }
        map.risk.push_back(std::move(irow));
    }

    map.w = int(map.risk[0].size());
    map.h = int(map.risk.size());

    return map;
}

int main() {
    timer t;

    auto map = readInput();
    cout << map.solve() << endl;

    Map map5;
    map5.w = map.w * 5;
    map5.h = map.h * 5;
    for (int i = 0; i < 5; ++i) {
        for (auto& mrow : map.risk) {
            auto& m5row = map5.risk.emplace_back();
            m5row.reserve(map5.w);
            for (int j = 0; j < 5; ++j) {
                for (auto v : mrow) {
                    auto newV = v + i + j;
                    if (newV > 9) newV -= 9;
                    m5row.push_back(newV);
                }
            }
        }
    }

    cout << map5.solve() << endl;
}