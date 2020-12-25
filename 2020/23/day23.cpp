#include <iostream>
#include <vector>
#include <list>
#include <string_view>
#include <cassert>
#include <array>
#include <algorithm>

#include "../cpp/timer.hpp"

static constexpr std::string_view input =
    "368195742"; // input
    // "389125467"; // example

using list = std::list<int>;
list cups;
std::vector<std::list<int>::iterator> cup_ids;

void push_cup(int cup) {
    cups.push_back(cup);
    cup_ids[size_t(cup) - 1] = std::next(cups.end(), -1);
}

void parse_input() {
    cup_ids.clear();
    cups.clear();
    cup_ids.resize(input.length());
    for (auto c : input) {
        int cup = c - '0';
        assert(cup > 0);
        push_cup(cup);
    }
}

void add_1mil() {
    constexpr size_t N = 1'000'000;
    cup_ids.resize(N);
    int cup = int(cups.size());
    while (cups.size() != N) {
        push_cup(++cup);
    }
}

void play_move() {
    // move cur to back
    list helper;
    helper.splice(helper.begin(), cups, cups.begin());
    cups.splice(cups.end(), helper);

    // take three
    helper.splice(helper.begin(), cups, cups.begin(), std::next(cups.begin(), 3));

    std::array<int, 3> taken;
    std::copy(helper.begin(), helper.end(), taken.begin());

    // find where to put them
    int next_cup = cups.back();
    do {
        --next_cup;
        if (next_cup == 0) next_cup = int(cup_ids.size());
    } while (std::find(taken.begin(), taken.end(), next_cup) != taken.end());

    auto next_cup_pos = cup_ids[next_cup-1];
    ++next_cup_pos;
    cups.splice(next_cup_pos, helper);
}

// reorder them to start after '1' and remove '1'
void normalize_cups() {
    list helper;
    auto one = cup_ids[0];
    helper.splice(helper.begin(), cups, cups.begin(), one);
    cups.splice(cups.end(), helper);
    cups.pop_front();
}

int main() {
    timer t;

    // a
    {
        parse_input();
        for (int i = 0; i < 100; ++i) play_move();
        normalize_cups();
        for (auto c : cups) std::cout << c;
        std::cout << '\n';
    }

    // b
    {
        parse_input();
        add_1mil();
        for (int i = 0; i < 10'000'000; ++i) play_move();
        normalize_cups();
        auto b = cups.begin();
        std::cout << uint64_t(*b) * uint64_t(*++b) << '\n';
    }

    return 0;
}
