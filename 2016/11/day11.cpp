#include "../cpp/timer.hpp"
#include <itlib/static_vector.hpp>
#include <map>
#include <regex>
#include <string>
#include <iostream>
#include <fstream>
#include <vector>
#include <unordered_set>

// lowest 2 bits are the elevator
// each subsequent two bits represent which floor an item is on
// items are in generator-chip pairs
//
// 0b00CzGzCyGyCxGxEE
using game_state = uint64_t;

struct game_info {
    uint32_t elem_count;
    uint32_t all;

    uint32_t item_count() const noexcept {
        return elem_count * 2;
    }

    static uint8_t elevator(game_state state) noexcept {
        return state & 3;
    }

    uint32_t floor(game_state state, uint8_t floor) const noexcept {
        uint32_t ret = 0;
        for (uint32_t i = 0; i < item_count(); ++i) {
            state >>= 2; // first eliminate the elevator bits
            if ((state & 3) == floor) {
                ret |= 1 << i;
            }
        }
        return ret;
    }

    bool item_on_floor(uint32_t floor, uint32_t item) const noexcept {
        return floor & (1 << item);
    }

    bool floor_valid(uint32_t floor) const noexcept {
        uint32_t microchips = 0;
        uint32_t generators = 0;
        for (uint32_t i = 0; i < elem_count; ++i) {
            if (floor & 1) generators |= 1 << i;
            if (floor & 2) microchips |= 1 << i;
            floor >>= 2;
        }
        return generators == 0 || (generators & microchips) == microchips;
    }

    bool floor_valid(game_state state, uint8_t nfloor) const noexcept {
        return floor_valid(floor(state, nfloor));
    }

    bool done(game_state state) const noexcept {
        return floor(state, 3) == all;
    }

    game_state set_item_floor(game_state state, uint32_t item, uint8_t floor) const noexcept {
        uint64_t mask = 3;
        mask <<= (item * 2 + 2);
        state &= ~mask;
        state |= uint64_t(floor) << (item * 2 + 2);
        return state;
    }

    game_state set_state_floor(game_state state, uint8_t floor) const noexcept {
        state &= ~uint64_t(3);
        state |= floor;
        return state;
    }
};

std::pair<game_info, game_state> parse_input() {
    std::ifstream file(INPUT_PATH "/input.txt");
    std::string line;

    std::map<std::string, uint32_t> elem_ids;
    game_state state = {};

    uint64_t floor = 0;
    while (std::getline(file, line)) {
        if (floor == 4) {
            std::cerr << "Too many floors\n";
            exit(1);
        }

        std::regex rect_re(R"(a ([a-z]+)([a-z\-]+)?)");
        for (std::smatch match; std::regex_search(line, match, rect_re); line = match.suffix()) {
            auto& elem = match[1];

            if (elem_ids.find(elem) == elem_ids.end()) {
                elem_ids[elem] = uint32_t(elem_ids.size());
            }
            auto id = elem_ids[elem];
            if (id >= 15) {
                std::cerr << "Too many elements\n";
                exit(1);
            }

            if (match[2].length() > 0) {
                state |= floor << (id * 4 + 2 + 2);
            }
            else {
                state |= floor << (id * 4 + 2);
            }

        }
        ++floor;
    }

    game_info info = {};
    info.elem_count = uint32_t(elem_ids.size());
    for (uint32_t i = 0; i < info.item_count(); ++i) {
        info.all |= 1 << i;
    }
    return {info, state};
}

void bfs_solve(const game_info& info, const game_state initial_state) {
    std::unordered_set<game_state> visited;
    visited.insert(initial_state);

    std::vector<game_state> states = {initial_state};
    std::vector<game_state> next_states;

    for (uint32_t step = 1; ; ++step) {
        for (const auto state : states) {
            auto cur_elevator = info.elevator(state);
            itlib::static_vector<uint8_t, 2> next_elevators;
            if (cur_elevator > 0) next_elevators.push_back(cur_elevator - 1);
            if (cur_elevator < 3) next_elevators.push_back(cur_elevator + 1);

            for (auto ne : next_elevators) {
                auto add_state = [&](game_state next_state) -> bool {
                    if (!info.floor_valid(next_state, cur_elevator)) return false;
                    if (!info.floor_valid(next_state, ne)) return false;

                    if (info.done(next_state)) {
                        std::cout << "Found solution in " << step << " steps\n";
                        return true;
                    }

                    if (visited.find(next_state) != visited.end()) return false;
                    visited.insert(next_state);

                    next_states.push_back(next_state);
                    return false;
                };

                auto state_floor = info.floor(state, cur_elevator);

                for (uint32_t a = 0; a < info.item_count(); ++a) {
                    if (!info.item_on_floor(state_floor, a)) continue;

                    // try moving one item
                    auto a_state = info.set_item_floor(state, a, ne);
                    a_state = info.set_state_floor(a_state, ne);
                    if (add_state(a_state)) return;

                    for (uint32_t b = a + 1; b < info.item_count(); ++b) {
                        // try moving two items
                        if (!info.item_on_floor(state_floor, b)) continue;
                        auto ab_state = info.set_item_floor(a_state, b, ne);
                        if (add_state(ab_state)) return;
                    }
                }
            }
        }
        states.swap(next_states);
        next_states.clear();

        if (states.empty()) {
            std::cout << "No solution found\n";
            return;
        }
        // std::cout << "Step " << step << ": " << states.size() << " states\n";
    }
}

int main() {
    timer t;
    auto [info, initial_state] = parse_input();

    // a
    bfs_solve(info, initial_state);

    // b
    info.all |= 0b1111 << info.item_count();
    info.elem_count += 2;
    // floor 0 for the new elements so initial_state is still valid
    bfs_solve(info, initial_state);

    return 0;
}
