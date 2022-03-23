#include <stdio.h>

int main() {
    int a, b, x, y, state;
    state = 0;
    while (1) {
        printf("Input a, b:\n");
        scanf("%d %d", &a, &b);
        switch (state) {
        case 0:
            state = 1;
            break;
        case 1:
            if (a == 1 && b == 0) {
                state = 2;
                x = 0;
                y = 0;
                printf("x = %d, y = %d\n", x, y);
            }
            else if (a == 0 && b == 1) {
                state = 1;
                x = 1;
                y = 0;
                printf("x = %d, y = %d\n", x, y);
            }
            else if (a == 0 && b == 0) {
                state = 1;
                x = 0;
                y = 0;
                printf("x = %d, y = %d\n", x, y);
            }
            else {
                state = 1;
                printf("a and b shall not be active at the same time.\n");
            }
            break;
        case 2:
            if (a == 1 && b == 0) {
                state = 1;
                x = 1;
                y = 0;
                printf("x = %d, y = %d\n", x, y);
            }
            else if (a == 0 && b == 1) {
                state = 1;
                x = 1;
                y = 1;
                printf("x = %d, y = %d\n", x, y);
            }
            else if (a == 0 && b == 0) {
                state = 2;
                x = 0;
                y = 0;
                printf("x = %d, y = %d\n", x, y);
            }
            else {
                state = 2;
                printf("a and b shall not be active at the same time.\n");
            }
            break;
        default:
            printf("Error: State %d should not occur!", state);
            break;
        }
    }
    return 0;
}