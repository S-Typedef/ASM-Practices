#include<stdio.h>
int main(){
    int a=1;
    int b=2;
    a=b=4;
    int t = ++a || ++b;
    printf("%d",b);
}