/* A called program written in C, for test340: an RPG program calls it
 * with EXTPGM('CSQUARE'). Each parameter arrives as a pointer to its
 * bytes in IBM i's format: INT(10) as a native int, CHAR(12) as 12
 * blank-padded bytes, PACKED(5:2) as 3 bytes of packed decimal. It returns
 * 0, or a negative value to end in error. */
#include <string.h>

#ifdef _WIN32
__declspec(dllexport)
#endif
int CSQUARE(int *n, char *text, unsigned char *amount) {
    int cents, i, digits[5];
    *n = *n * *n;
    memcpy(text, "from C      ", 12);
    /* amount PACKED(5:2): digits in nibbles, sign in the last (D negative) */
    cents = 0;
    for (i = 0; i < 2; i++)
        cents = cents * 100 + (amount[i] >> 4) * 10 + (amount[i] & 0x0F);
    cents = cents * 10 + (amount[2] >> 4);
    if ((amount[2] & 0x0F) == 0x0D) cents = -cents;
    cents = -cents * 2;                          /* double it and flip the sign */
    {
        int v = cents < 0 ? -cents : cents;
        for (i = 4; i >= 0; i--) { digits[i] = v % 10; v /= 10; }
    }
    amount[0] = (unsigned char)(digits[0] << 4 | digits[1]);
    amount[1] = (unsigned char)(digits[2] << 4 | digits[3]);
    amount[2] = (unsigned char)(digits[4] << 4 | (cents < 0 ? 0x0D : 0x0C));
    return 0;
}
