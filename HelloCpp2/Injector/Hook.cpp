//
//  Hook.cpp
//  Injector
//
//  Created by wesley_chen on 2023/3/29.
//

#include <iostream>

void* operator new(std::size_t size) {
    std::cout << "Allocating " << size << " bytes" << std::endl;
    void* ptr = std::malloc(size);
    return ptr;
}

void operator delete(void* ptr) noexcept {
    std::cout << "free " << ptr << std::endl;
    std::free(ptr);
}
