// brute force recurse all possible games
#include <iostream>
#include <fstream>
#include <string>
#include <cstdint>
#include <cassert>
#include <climits>

#include "../cpp/timer.hpp"

using namespace std;

struct Map {
    enum AType : uint8_t { A, B, C, D, E };
    static constexpr int costPerMove[] = { 1, 10, 100, 1000 };
    struct Amphi {
        AType type = E;
        uint8_t moves = 0;
        explicit operator bool() const { return type != E; }
        bool done() const { return moves > 1; }
        void clear() { type = E; }
    };
    static constexpr int RD = 4;
    struct Cell {
        Amphi occupants[RD];
        bool done() const {
            for (auto& o : occupants) {
                if (!o || !o.done()) return false;
            }
            return true;
        }
        Amphi& occupant(int i = 0) { return occupants[i]; }
        const Amphi& occupant(int i = 0) const { return occupants[i]; }
    };
    static constexpr int NC = 11;
    Cell cells[NC];

    bool done() const {
        for (auto r : rooms) {
            if (!cells[r].done()) return false;
        }
        return true;
    }

    static constexpr int rooms[4] = { 2, 4, 6, 8 };
    static bool room(int n) {
        for (auto r : rooms) if (r == n) return true;
        return false;
    }

    std::pair<int, int> hallLimits(int pos) const {
        int begin = pos;
        for (; begin > 0; --begin) {
            if (room(begin-1)) continue;
            if (cells[begin-1].occupant()) break;
        }

        int end = pos + 1;
        for (; end < NC; ++end) {
            if (room(end)) continue;
            if (cells[end].occupant()) break;
        }

        return {begin, end};
    }

    void markDone() {
        // mark ones already in place as dones
        for (int i = 0; i < 4; ++i) {
            auto r = Map::rooms[i];
            for (int oi = RD-1; oi >= 0; --oi) {
                auto& o = cells[r].occupants[oi];
                if (o.type == i) {
                    o.moves = 100;
                }
                else {
                    break;
                }
            }
        }
    }

    void print() const {
        static constexpr char T2N[] = { 'A', 'B', 'C', 'D', '.' };
        for (int i = 0; i < NC; ++i) {
            if (room(i)) {
                cout << '.';
            }
            else {
                cout << T2N[cells[i].occupant().type];
            }
        }
        cout << '\n';
        for (int r = 0; r < Map::RD; ++r) {
            for (int i = 0; i < NC; ++i) {
                if (room(i)) {
                    cout << T2N[cells[i].occupant(r).type];
                }
                else {
                    cout << ' ';
                }
            }
            cout << '\n';
        }
    }
};

Map readInput() {
    ifstream fin(INPUT_PATH"/input.txt");

    Map ret;
    for(int i=0; i<4; ++i) {
        string row;
        getline(fin, row);
        if (i > 1) {
            for (auto r : Map::rooms) {
                ret.cells[r].occupants[i - 2].type = Map::AType(row[r+1] - 'A');
            }
        }
    }

    return ret;
}

int minCost = INT_MAX;

void bf(const Map& map, const int total) {
    if (total >= minCost) return;
    if (map.done()) {
        if (minCost > total) minCost = total;
        return;
    }

    auto recurse = [&](int from, int levelfrom, int to, int levelto) {
        auto& o = map.cells[from].occupants[levelfrom];
        assert(!o.done());
        auto newMap = map;
        newMap.cells[from].occupants[levelfrom].clear();
        newMap.cells[to].occupants[levelto] = {o.type, uint8_t(o.moves + 1)};
        auto cost = (abs(from - to) + levelfrom + levelto + 1) * Map::costPerMove[o.type];
        bf(newMap, total + cost);
    };

    for (int pos = 0; pos < Map::NC; ++pos) {
        auto& src = map.cells[pos];
        if (Map::room(pos)) {
            int level = 0;
            for (; level < Map::RD; ++level) {
                if (src.occupants[level]) break;
            }
            if (level == Map::RD) continue; // empty room
            auto& o = src.occupants[level];
            if (o.done()) continue; // room done (so far)
            auto [b, e] = map.hallLimits(pos);
            for (int hi = b; hi < e; ++hi) {
                if (Map::room(hi)) continue;
                recurse(pos, level, hi, 0);
            }
        }
        else {
            auto& o = src.occupant();
            if (!o) continue;
            assert(o.moves == 1);
            auto targetPos = Map::rooms[o.type];
            auto [b, e] = map.hallLimits(pos);
            if (targetPos < b || targetPos >= e) continue; // road to home is blocked
            auto& target = map.cells[targetPos];
            auto targetLevel = Map::RD;
            for (int i = Map::RD - 1; i >= 0; --i) {
                auto& roomo = target.occupants[i];
                if (!roomo) {
                    targetLevel = i;
                    break;
                }
                else if (roomo.type != o.type) {
                    break;
                }
            }
            if (targetLevel == Map::RD) continue; // home bottom is occupied by someone who needs to move
            recurse(pos, 0, targetPos, targetLevel);
        }
    }
}

int main() {
    auto map = readInput();

    // a
    {
        timer t;
        auto mapA = map;
        for (auto r : Map::rooms) {
            for (int i = 2; i < Map::RD; ++i) {
                mapA.cells[r].occupants[i].type = Map::AType(r / 2 - 1);
            }
        }
        // mapA.print();
        mapA.markDone();
        bf(mapA, 0);
        cout << "a: " << minCost << endl;
    }

    minCost = INT_MAX;

    // b
    {
        timer t;
        auto mapB = map;
        static_assert(Map::RD == 4);
        for (auto r : Map::rooms) {
            auto& c = mapB.cells[r];
            c.occupants[3] = c.occupants[1];
        }
        mapB.cells[Map::rooms[0]].occupants[1].type = Map::D;
        mapB.cells[Map::rooms[0]].occupants[2].type = Map::D;
        mapB.cells[Map::rooms[1]].occupants[1].type = Map::C;
        mapB.cells[Map::rooms[1]].occupants[2].type = Map::B;
        mapB.cells[Map::rooms[2]].occupants[1].type = Map::B;
        mapB.cells[Map::rooms[2]].occupants[2].type = Map::A;
        mapB.cells[Map::rooms[3]].occupants[1].type = Map::A;
        mapB.cells[Map::rooms[3]].occupants[2].type = Map::C;

        mapB.markDone();
        bf(mapB, 0);
        cout << "b: " << minCost << endl;
    }
}
