#include<stdio.h>
#include<string.h>

char a[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
int len = sizeof(a)/sizeof(char);

void print(int b){
    if(b)
        print(b/len);
    printf("%c",a[b%len]);
}

int main(){

    int fvv_9;
    int b = 0;
    scanf("%d",&b);
    print(b);
}