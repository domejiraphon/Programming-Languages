// countdown using a for loop
#include <iostream>
using namespace std;

void mystery (int& a1, int& a2, int& a3, int& a4, int& a5) {
    for (int count=1; count<=3; count++) {
        a1 = a2 +a4;
        a4 = a4 + a1;
        a5 = (a3 + a2)*2;
        cout << "a1:" << a1 << " a2:"<< a2 << " a3:"<< a3 << " a4:"<< a4 << " a5:" << a5 << endl;
    }
} 


int main ()
{
  

}