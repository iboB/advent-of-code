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
list cards;
std::vector<std::list<int>::iterator> card_ids;

void push_card(int card) {
    cards.push_back(card);
    card_ids[size_t(card) - 1] = std::next(cards.end(), -1);
}

void parse_input() {
    card_ids.clear();
    cards.clear();
    card_ids.resize(input.length());
    for (auto c : input) {
        int card = c - '0';
        assert(card > 0);
        push_card(card);
    }
}

void add_1mil() {
    constexpr size_t N = 1'000'000;
    card_ids.resize(N);
    int card = int(cards.size());
    while (cards.size() != N) {
        push_card(++card);
    }
}

void play_move() {
    // move cur to back
    list helper;
    helper.splice(helper.begin(), cards, cards.begin());
    cards.splice(cards.end(), helper);

    // take three
    helper.splice(helper.begin(), cards, cards.begin(), std::next(cards.begin(), 3));

    std::array<int, 3> taken;
    std::copy(helper.begin(), helper.end(), taken.begin());

    // find where to put them
    int next_card = cards.back();
    do {
        --next_card;
        if (next_card == 0) next_card = int(card_ids.size());
    } while (std::find(taken.begin(), taken.end(), next_card) != taken.end());

    auto next_card_pos = card_ids[next_card-1];
    ++next_card_pos;
    cards.splice(next_card_pos, helper);
}

// reorder them to start after '1' and remove '1'
void normalize_cards() {
    list helper;
    auto one = card_ids[0];
    helper.splice(helper.begin(), cards, cards.begin(), one);
    cards.splice(cards.end(), helper);
    cards.pop_front();
}

int main() {
    timer t;

    // a
    {
        parse_input();
        for (int i = 0; i < 100; ++i) play_move();
        normalize_cards();
        for (auto c : cards) std::cout << c;
        std::cout << '\n';
    }

    // b
    {
        parse_input();
        add_1mil();
        for (int i = 0; i < 10'000'000; ++i) play_move();
        normalize_cards();
        auto b = cards.begin();
        std::cout << uint64_t(*b) * uint64_t(*++b) << '\n';
    }

    return 0;
}
