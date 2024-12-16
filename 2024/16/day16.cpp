// dfs find all best paths

#include "../cpp/timer.hpp"
#include <iostream>
#include <fstream>
#include <unordered_set>
#include <unordered_map>
#include <complex>

using point = std::complex<int>;

struct pt_hash {
    size_t operator()(const point& p) const {
        return std::hash<uint64_t>()((uint64_t(p.real()) << 32) | uint64_t(p.imag()));
    }
};

std::unordered_set<point, pt_hash> walls;
std::unordered_map<point, int, pt_hash> visited;
point start, end;
int best = 1'000'000'000;
std::vector<std::pair<std::vector<point>, int>> paths;

std::vector<std::pair<point, int>> dirs = {
    {{1, 0}, 1},
    {{0, 1}, 1001},
    {{0, -1}, 1001}
};

void find_path(const point& cur, const point& dir, int pts, std::vector<point>& path) {
    if (pts > best) return;
    auto f = visited.find(cur);
    if (f != visited.end() && f->second < pts) return;

    // don't count junctions so as not to prioritize non-turning paths
    int outs = 0;
    for (auto& d : dirs) {
        auto next_dir = dir * d.first;
        auto next_pt = cur + next_dir;
        if (!walls.count(next_pt)) outs++;
    }
    if (outs == 1) visited[cur] = pts;

    if (cur == end) {
        if (best >= pts) {
            best = pts;
            paths.push_back({path, pts});
        }
        return;
    }
    for (auto& d : dirs) {
        auto next_dir = dir * d.first;
        auto next_pt = cur + next_dir;
        if (walls.count(next_pt)) continue;
        path.push_back(next_pt);
        find_path(next_pt, next_dir, pts + d.second, path);
        path.pop_back();
    }
}

int main() {
    std::ifstream file(INPUT_PATH "/input.txt");
    std::string line;

    int y = 0;
    while (std::getline(file, line)) {
        for (int x = 0; x < line.size(); x++) {
            point pt = {x, y};
            switch (line[x]) {
            case '#': walls.insert(pt); break;
            case 'S': start = pt; break;
            case 'E': end = pt; break;
            }
        }
        ++y;
    }

    {
        timer t;
        std::vector<point> path = {start};
        find_path(start, {1, 0}, 0, path);
    }

    std::cout << best << std::endl;

    std::unordered_set<point, pt_hash> best_path_points;
    for (auto& p : paths) {
        if (p.second != best) continue;
        for (auto& pt : p.first) best_path_points.insert(pt);
    }
    std::cout << best_path_points.size() << std::endl;
    return 0;
}