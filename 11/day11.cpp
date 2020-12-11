#include <fstream>
#include <iostream>
#include <vector>
#include <string>
#include <cassert>

using namespace std;

struct Vec
{
    int x, y;
    Vec& operator+=(Vec o) {
        x += o.x;
        y += o.y;
        return *this;
    }
    bool oob(Vec max) const { // out of bounds
        return !(x >= 0 && y >= 0 && x < max.x && y < max.y);
    }
};

const Vec dirs[] = { {1,-1}, {1,0}, {1,1}, {-1,-1}, {-1,0}, {-1,1}, {0,1}, {0,-1} };

struct Room {
    vector<string> data;
    Vec size;

    void dbg_print() {
        for (auto& row : data) cout << row << '\n';
    }

    void init() {
        size.y = int(data.size());
        assert(!data.empty());
        assert(data.front().size() == data.back().size());
        size.x = int(data.front().size());
    }

    struct Ray {
        Ray(const Room& r, Vec d, Vec p) : room(r), dir(d), pos(p) {}
        const Room& room;
        const Vec dir;
        Vec pos;

        Ray& operator++() {
            pos += dir;
            return *this;
        }

        bool cast() {
            while (true) {
                pos += dir;
                if (pos.oob(room.size)) return false;
                auto c = room.at(pos);
                if (c == 'L') return false;
                if (c == '#') return true;
            }
        }

        bool occupied() const {
            if (pos.oob(room.size)) return false;
            return room.at(pos) == '#';
        }
    };

    char& at(Vec p) { return data[p.y][p.x]; }
    char at(Vec p) const { return data[p.y][p.x]; }

    char query_a(Vec p) const {
        auto cur = at(p);
        if (cur == '.') return cur;

        int sum = 0;
        for (auto& d : dirs) {
            Ray r(*this, d, p);
            ++r;
            sum += r.occupied();
        }

        if (cur == 'L' && sum == 0) return '#';
        if (cur == '#' && sum >= 4) return 'L';
        return cur;
    }

    char query_b(Vec p) const {
        auto cur = at(p);
        if (cur == '.') return cur;

        int sum = 0;
        for (auto& d : dirs) {
            Ray r(*this, d, p);
            sum += r.cast();
        }

        if (cur == 'L' && sum == 0) return '#';
        if (cur == '#' && sum >= 5) return 'L';
        return cur;
    }

    template <typename Q>
    void iteration(Room& out, Q q) const {
        out = *this; // for size only

        Vec i = {0, 0};
        for (; i.y < size.y; ++i.y) {
            i.x = 0;
            for (; i.x < size.x; ++i.x) {
                out.at(i) = (this->*q)(i);
            }
        }
    }

    int count() const {
        int sum = 0;
        for (auto& row : data) for (auto c : row) sum += c == '#';
        return sum;
    }

    friend bool operator==(const Room& a, const Room& b) { return a.data == b.data; }
};

Room readInput() {
    Room room;
    ifstream fin(INPUT_PATH"/input.txt");

    while (!fin.eof()) {
        std::string row;
        std::getline(fin, row);
        if (row.empty()) break;
        room.data.emplace_back(std::move(row));
    }

    room.init();
    return room;
}

template <typename Q>
void solve(Room sol, Q q) {
    Room tmp;
    while (true) {
        sol.iteration(tmp, q);
        if (sol == tmp) break;
        std::swap(sol, tmp);
    }

    cout << sol.count() << '\n';
}

int main() {
    auto room = readInput();

    solve(room, &Room::query_a);
    solve(room, &Room::query_b);
}
