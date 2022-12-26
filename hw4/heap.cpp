// function example
#include <iostream>
using namespace std;

class Vehicle {
  public:
    int x;
    virtual void f() {cout << "vehicle f()" << endl;};
    void g(){cout << "vehicle g()" << endl;};
  };
class Airplane : public Vehicle {
  public:
    int y;
    virtual void f(){cout << "airplane f()" << endl;};
    virtual void h(){cout << "airplane h()" << endl;};
};
void inHeap() {
  Vehicle *b1 = new Vehicle; // Allocate object on the heap
  Airplane *d1 = new Airplane; // Allocate object on the heap
  b1->x = 1;
  d1->x = 2;
  d1->y = 3;
  /*
  b1 -> f();
  b1 -> g();
  d1 -> f();
  d1 -> h();*/
  b1 = d1; // Assign derived class object to base class pointer
  /*
  b1 -> f();
  b1 -> g();
  cout << b1 -> x << endl;
  d1 -> f();
  d1 -> h();*/
}
void onStack() {
  Vehicle b2; // Local object on the stack
  Airplane d2; // Local object on the stack
  b2.x = 4;
  d2.x = 5;
  d2.y = 6;
  /*
  b2.f();
  b2.g();
  d2.f();
  d2.h();*/
  b2 = d2; // Assign derived class object to base class variable
  b2.f();
  b2.g();
  cout << b2.x << endl;
  d2.f();
  d2.h();
}

int main() {
  //inHeap();
  onStack();
  //onStackptr();
}