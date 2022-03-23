#include <stdio.h>

int main() {
    int currentcounter, nextcounter = 0;
    int bottle, return_coin = 0;
    int coin5, coin10 = 0;
    int i = 1;
    while (1) {
        printf("#step %d\n", i);
        scanf("%d %d", &coin5, &coin10);
        if (coin5 == 1 & coin10 == 0) {
            currentcounter = nextcounter + 5;
        }
        else if (coin5 == 0 & coin10 == 1) {
            currentcounter = nextcounter + 10;
        }
        else {
            currentcounter = nextcounter;
        }

        if (currentcounter >= 10) {
            nextcounter = 0;
        }
        else if (currentcounter >= 5) {
            nextcounter = 5;
        }
        else {
            nextcounter = 0;
        }

        if (currentcounter >= 10) {
            bottle = 1;
        }
        else {
            bottle = 0;
        }

        if (currentcounter >= 15) {
            return_coin = 1;
        }
        else {
            return_coin = 0;
        }

        printf("%d %d", bottle, return_coin);
        printf("\n");
        i++;
    }
    return 0;
}