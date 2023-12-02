#include <itlib/stride_span.hpp>
#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#include <fstream>
#include <regex>

class grid {
    size_t m_rows, m_cols;
    std::vector<char> m;
public:
    grid(size_t rows, size_t cols)
        : m_rows(rows), m_cols(cols), m(rows * cols, '.') {}

    itlib::stride_span<char> row(size_t row) {
        return itlib::make_stride_span_from_buf(m.data() + row * m_cols, sizeof(char), m_cols);
    }

    itlib::stride_span<char> column(size_t col) {
        return itlib::make_stride_span_from_buf(m.data() + col, m_cols, m_rows);
    }

    void rect(size_t rows, size_t cols) {
        for (size_t row = 0; row < rows; ++row) {
            auto r = this->row(row);
            r = r.subspan(0, cols);
            for(auto& c : r) c = '#';
        }
    }

    size_t count_lit() const {
        return std::count(m.begin(), m.end(), '#');
    }

    void print() {
        for (size_t row = 0; row < m_rows; ++row) {
            auto r = this->row(row);
            for (auto c : r) std::cout << c;
            std::cout << '\n';
        }
    }
};

int main() {
    std::ifstream file(INPUT_PATH "/input.txt");

    grid g(6, 50);

    std::string line;
    while (std::getline(file, line)) {
        std::cout << line << '\n';
        std::regex rect_re(R"(rect (\d+)x(\d+))");
        std::regex rotate_re(R"(rotate (row|column) [xy]=(\d+) by (\d+))");

        std::smatch match;
        if (std::regex_match(line, match, rect_re)) {
            size_t x = std::stoi(match[1]);
            size_t y = std::stoi(match[2]);
            g.rect(y, x);
        }
        else if (std::regex_match(line, match, rotate_re)) {
            std::string type = match[1];
            itlib::stride_span<char> s;
            if (type == "row") s = g.row(std::stoi(match[2]));
            else if (type == "column") s = g.column(std::stoi(match[2]));

            size_t index = std::stoi(match[2]);
            size_t amount = std::stoi(match[3]);
            std::rotate(s.begin(), s.end() - amount, s.end());
        }
    }

    std::cout << g.count_lit() << '\n';
    g.print();

    return 0;
}
