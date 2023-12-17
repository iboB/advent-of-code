#include <iostream>
#include <fstream>
#include <cstdint>
#include <string>
#include <vector>
#include <complex>
#include <limits>
#include <cassert>
#include <deque>
#include "../cpp/timer.hpp"

struct limits {
    int from, to;
};
constexpr limits LIMITS_A = { 0, 3 };
constexpr limits LIMITS_B = { 3, 10 };

struct vec {
    int32_t x, y;
    vec& operator+=(vec o) {
        x += o.x;
        y += o.y;
        return *this;
    }
};

enum dirname {down, right, up, left};
const vec dirs[4] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
const dirname perp[4][2] = {
    {left, right},
    {down, up},
    {right, left},
    {up, down}
};

struct node;

struct link {
    node* n = nullptr;
    int loss = -1;
    int best_loss = std::numeric_limits<int>::max();
};

struct node {
    int loss = 0;
    link links[4][LIMITS_B.to];
};

struct bfs_node {
    node* n;
    dirname from_dir;
    int loss;
};

template <limits L>
void bfs(bfs_node start) {
    std::deque<bfs_node> queue{start};
    while (!queue.empty()) {
        const auto [n, from_dir, loss] = queue.front();
        queue.pop_front();
        for (auto next_dirname : perp[from_dir]) {
            for (int i = L.from; i < L.to; ++i) {
                auto& link = n->links[next_dirname][i];
                if (!link.n) break;
                if (loss >= link.best_loss) continue;
                link.best_loss = loss;
                queue.push_back({link.n, next_dirname, loss + link.loss});
            }
        }
    }
}

template <limits L>
int min_loss(const node& n) {
    auto min = std::numeric_limits<int>::max();
    for (auto& links : n.links) {
        for (int i = L.from; i < L.to; ++i) {
            auto& link = links[i];
            if (!link.n) break;
            min = std::min(min, link.best_loss);
        }
    }
    return min;
}

int main() {
    std::ifstream file(INPUT_PATH"/input.txt");
    std::string line;
    std::vector<std::vector<node>> level;
    while (std::getline(file, line)) {
        auto& row = level.emplace_back();
        for (auto c : line) {
            auto& n = row.emplace_back();
            n.loss = c - '0';
        }
    }
    assert(level.size() == level[0].size());

    // fill links
    for (int y = 0; y < level.size(); ++y) {
        for (int x = 0; x < level.size(); ++x) {
            auto& cur = level[y][x];
            for (int d = 0; d < 4; ++d) {
                auto& links = cur.links[d];
                auto dir = dirs[d];
                int loss = 0;
                auto pos = vec{x, y};
                for (int i = 0; i < LIMITS_B.to; ++i) {
                    pos += dir;
                    if (pos.x < 0 || pos.y < 0) break;
                    if (pos.x >= level.size() || pos.y >= level.size()) break;
                    auto& n = level[pos.y][pos.x];
                    loss += n.loss;
                    links[i].n = &n;
                    links[i].loss = loss;
                }
            }
        }
    }

    {
        timer t;
        bfs<LIMITS_A>({&level[0][0], right, 0});
        bfs<LIMITS_A>({&level[0][0], down, 0});
        std::cout << min_loss<LIMITS_A>(level.back().back()) << '\n';
    }

    {
        timer t;
        bfs<LIMITS_B>({&level[0][0], right, 0});
        bfs<LIMITS_B>({&level[0][0], down, 0});
        std::cout << min_loss<LIMITS_B>(level.back().back()) << '\n';
    }

    return 0;
}
