#if defined(__INTELLISENSE__)
#include <array>
#include <print>
#else
import std; // Replaces <print>, <array>, and <vector>
#endif

int main() {
    std::array<int, 5> numbers = {10, 20, 30, 40, 50};
    
    // std::println handles formatting for the container automatically
    std::println("Printing array via import std: {}", numbers);
}
