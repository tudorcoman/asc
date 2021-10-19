
#include <stdio.h>

int main() {
    short a = 63, b = 46;

    short ans = (a & (~b)) | ((~a) & b);
    printf("%d\n", ans);
    return 0;
}
