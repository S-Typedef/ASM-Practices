#define size 50

#include<stdio.h>
int main(){
    int x[size];
    int y[size];
    int *p;
    int *q;
    int i;
    for (i=0;i<size;i+=1){
        x[i]=y[i];
    }
    for(p=x,q=y;p-x<size;){
        *p++=*q++;
    }
    for (i=0,p=x,q=y;i<size;i++){
        *p++=*q++;
    }
    register int *p1,*q1;
    register int j;
    for(j=0,p1=x,q1=y;j<size;i++){
        *p1++=*q1++;
    }
    for(p1=x,q1=y;p1<&x[size];){
        *p1++=*q1++;
    }
}
