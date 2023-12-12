#include <iostream>
#include <fstream>
#include <string>
#include <string_view>
#include <vector>
#include <cstdint>
#include <span>
#include <optional>
#include "../cpp/timer.hpp"

struct input {
    std::string pattern;
    std::vector<int> damaged;
};

bool can_place_here(std::string_view pattern, int damaged) {
    if (pattern[damaged] == '#') return false;
    for (int i = 0; i < damaged; ++i) {
        if (pattern[i] == '.') return false;
    }
    return true;
}

struct memo {
    memo(std::string_view pattern, std::span<const int> damaged)
        : data(pattern.length() + 1, std::vector<int64_t>(damaged.size() + 1, -1)) {}
    std::vector<std::vector<int64_t>> data;

    struct node {
        int64_t& value;
        explicit operator bool() const { return value != -1; }
        int64_t memoize(int64_t v) { return value = v; }
    };

    node get(std::string_view pattern, std::span<const int> damaged) {
        return {data[pattern.length()][damaged.size()]};
    }
};

int64_t count(std::string_view pattern, std::span<const int> damaged, memo& m) {
    auto k = m.get(pattern, damaged);
    if (k) return k.value;

    if (damaged.empty()) {
        return k.memoize(std::find(pattern.begin(), pattern.end(), '#') == pattern.end());
    }

    auto cur = damaged.front();

    if (pattern.length() <= cur) return k.memoize(0);

    int64_t found = 0;

    if (can_place_here(pattern, cur)) {
        found += count(pattern.substr(cur + 1), damaged.subspan(1), m);
    }

    if (pattern[0] == '#') return k.memoize(found);

    found += count(pattern.substr(1), damaged, m);
    return k.memoize(found);
}

int64_t count(const input& in) {
    std::string aug_pattern = in.pattern + '.'; // add trailing dot to make it easier to count
    memo m(aug_pattern, in.damaged);
    return count(aug_pattern, in.damaged, m);
}

int64_t solve(std::span<const input> inputs) {
    int64_t found = 0;
    for (auto& in : inputs) {
        found += count(in);
    }
    return found;
}

int main() {
    std::ifstream file(INPUT_PATH"/input.txt");
    std::string line;
    std::vector<input> inputs;
    while (std::getline(file, line)) {
        auto& in = inputs.emplace_back();

        auto space = line.find(' ');
        in.pattern = line.substr(0, space);

        auto rest = std::string_view(line).substr(space + 1);

        while (true) {
            auto comma = rest.find(',');
            in.damaged.push_back(std::stoi(std::string(rest.substr(0, comma))));
            if (comma == std::string_view::npos) break;
            rest = rest.substr(comma + 1);
        }
    }

    // a
    {
        timer t;
        std::cout << solve(inputs) << '\n';
    }

    // b
    for (auto& in : inputs) {
        auto orig_pattern = in.pattern;
        auto orig_damaged = in.damaged;
        for (int i = 0; i < 4; ++i) {
            in.pattern += '?';
            in.pattern += orig_pattern;
            in.damaged.insert(in.damaged.end(), orig_damaged.begin(), orig_damaged.end());
        }
    }
    {
        timer t;
        std::cout << solve(inputs) << '\n';
    }

    return 0;
}
