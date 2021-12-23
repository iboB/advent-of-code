#include <iostream>
#include <fstream>
#include <string>
#include <cstdint>
#include <cassert>

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
    struct Cell {
        Amphi occupants[2];
        bool empty() const {
            return !occupants[0] && !occupants[1];
        }
        bool done() const {
            return occupants[0] && occupants[0].done() && occupants[1] && occupants[1].done();
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
        for (int r = 0; r < 2; ++r) {
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
    int i = 0;
    while (true) {
        string row;
        getline(fin, row);
        if (i > 1) {
            for (auto r : Map::rooms) {
                ret.cells[r].occupants[i - 2].type = Map::AType(row[r+1] - 'A');
            }
        }
        ++i;
        if (i == 4) break;
    }

    // mark ones already in place as dones
    for (int i = 0; i < 4; ++i) {
        auto r = Map::rooms[i];
        if (ret.cells[r].occupant(1).type == i) {
            ret.cells[r].occupant(1).moves = 100;
            if (ret.cells[r].occupant(0).type == i) {
                ret.cells[r].occupant(0).moves = 100;
            }
        }
    }

    return ret;
}

int minCost = INT_MAX;

void bf(const Map& map, const int total) {
    if (map.done()) {
        if (minCost > total) minCost = total;
        return;
    }
    if (total > minCost) return;

    auto recurse = [&](int from, int levelfrom, int to, int levelto) {
        auto& o = map.cells[from].occupants[levelfrom];
        assert(!o.done());
        auto newMap = map;
        newMap.cells[from].occupants[levelfrom].clear();
        newMap.cells[to].occupants[levelto] = {o.type, uint8_t(o.moves + 1)};
        auto cost = (abs(from - to) + levelfrom + levelto + 1) * Map::costPerMove[o.type];
        bf(newMap, total + cost);
        //printf("%d %d -> %d %d (%d)\n", from, levelfrom, to, levelto, cost);
        //newMap.print();
        //cout << endl;
    };

    for (int pos = 0; pos < Map::NC; ++pos) {
        auto& src = map.cells[pos];
        if (auto& o = src.occupant()) {
            if (o.moves == 0) { // never moved (it's a room)
                auto [b, e] = map.hallLimits(pos);
                for (int hi = b; hi < e; ++hi) {
                    if (Map::room(hi)) continue;
                    recurse(pos, 0, hi, 0);
                }
            }
            else if (o.moves == 1) { // moved once (in the hallway)
                auto targetPos = Map::rooms[o.type];
                auto [b, e] = map.hallLimits(pos);
                if (targetPos < b || targetPos >= e) continue; // can't go home
                auto& target = map.cells[targetPos];
                if (target.occupant()) continue; // home is blocked
                if (target.occupant(1)) {
                    if (target.occupant(1).type != o.type) continue; // home bottom is occupied by someone who needs to move
                    recurse(pos, 0, targetPos, 0);
                }
                else {
                    recurse(pos, 0, targetPos, 1);
                }
            }
            // otherwise occupant is done
        }
        else if (auto& o = src.occupant(1)) { // bottom of room
            if (o.moves == 0) { // never moved (it's a room)
                auto [b, e] = map.hallLimits(pos);
                for (int hi = b; hi < e; ++hi) {
                    if (Map::room(hi)) continue;
                    recurse(pos, 1, hi, 0);
                }
            }
        }
    }
}

int main() {
    timer t;
    auto map = readInput();
    bf(map, 0);
    cout << minCost << endl;
}