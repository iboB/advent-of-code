#include <iostream>
#include <vector>
#include <limits>

#include "../cpp/timer.hpp"

using namespace std;

constexpr int boss_damage = 9;

struct game_state {
    int player_hp;
    int player_mana;
    int boss_hp;

    int shield_timer;
    int poison_timer;
    int recharge_timer;

    int mana_spent;

    void apply_effects() {
        if (shield_timer > 0) {
            --shield_timer;
        }
        if (poison_timer > 0) {
            boss_hp -= 3;
            --poison_timer;
        }
        if (recharge_timer > 0) {
            player_mana += 101;
            --recharge_timer;
        }
    }

    void boss_attack() {
        int damage = boss_damage;
        if (shield_timer > 0) {
            damage -= 7;
        }
        if (damage < 1) {
            damage = 1;
        }
        player_hp -= damage;
    }
};

struct spell {
    int mana_cost;

    int damage;
    int heal;

    int effect_length;
    int game_state::*counter;

    void cast(game_state& state) const {
        state.player_mana -= mana_cost;
        state.mana_spent += mana_cost;

        state.player_hp += heal;
        state.boss_hp -= damage;

        if (effect_length > 0) {
            state.*counter = effect_length;
        }
    }

    bool can_cast(const game_state& state) const {
        if (state.player_mana < mana_cost) return false;
        if (counter) return state.*counter <= 1;
        return true;
    }
};

const spell spells[] = {
    spell{ .mana_cost = 53, .damage = 4 },
    spell{ .mana_cost = 73, .damage = 2, .heal = 2 },
    spell{ .mana_cost = 113, .effect_length = 6, .counter = &game_state::shield_timer },
    spell{ .mana_cost = 173, .effect_length = 6, .counter = &game_state::poison_timer },
    spell{ .mana_cost = 229, .effect_length = 5, .counter = &game_state::recharge_timer },
};

int solve(const bool hard) {
    std::vector<game_state> states = { game_state{
        .player_hp = 50,
        .player_mana = 500,
        .boss_hp = 51,
    } };

    std::vector<game_state> next_states;

    int min_mana_spent = std::numeric_limits<int>::max();

    while (true) {
        for (const auto& state : states) {
            if (hard && state.player_hp == 1) {
                // end with loss, no point in checking casts
                continue;
            }

            for (const auto& spell : spells) {
                if (!spell.can_cast(state)) continue;

                // player turn
                game_state next_state = state;

                if (hard) {
                    --next_state.player_hp;
                }

                next_state.apply_effects();
                spell.cast(next_state);

                if (next_state.mana_spent >= min_mana_spent) {
                    // no need to continue, we already have a better solution
                    continue;
                }

                // boss turn
                next_state.apply_effects();

                if (next_state.boss_hp <= 0) {
                    // boss either died in player's turn or from in their turn from poison
                    // either way, we have a win and a new best solution
                    min_mana_spent = next_state.mana_spent;
                    continue;
                }

                next_state.boss_attack();

                if (next_state.player_hp <= 0) {
                    // end with loss
                    continue;
                }

                next_states.push_back(next_state);
            }
        }

        if (next_states.empty()) {
            break;
        }

        //cout << next_states.size() << endl;

        states.swap(next_states);
        next_states.clear();
    }

    return min_mana_spent;
}

int main() {
    timer t;
    cout << solve(false) << endl; // a
    cout << solve(true) << endl; // b
    return 0;
}
