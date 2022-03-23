/* module SDF_Application where */

/* import ForSyDe.Shallow */

/* system :: Signal Int -> Signal Int -> Signal Int */
/* system s_in1 s_in2 = s_out where */
/*   s_1 = actor_a s_in1 */
/*   s_2 = actor_b s_in2 */
/*   s_3 = actor_c s_1 s_4_delayed */
/*   (s_4, s_out) = actor_d s_2 s_3 */
/*   s_4_delayed = delaySDF [0] s_4 */

/* actor_a :: Signal Int -> Signal Int */
/* actor_a = actor11SDF 2 1 f_1 where */
/*   f_1 [x, y] = [x + y] */

/* actor_b :: Signal Int -> Signal Int */
/* actor_b = actor11SDF 1 2 f_2 where */
/*   f_2 [x] = [x, x+1] */

/* actor_c :: Signal Int -> Signal Int -> Signal Int */
/* actor_c = actor21SDF (2,1) 1 f_3 where */
/*   f_3 [x, y] [z] = [x + y + z] */

/* actor_d :: Signal Int -> Signal Int -> (Signal Int, Signal Int) */
/* actor_d = actor22SDF (2,1) (1,2) f_4 where */
/*   f_4 [x, y] [z] = ([x + y + z], [x + y, x + y + z])  */
  

/* Use DEBUG INFORMATION when the program does not run correctly */
#define DEBUG 0

/*
 * The data type token needs to be defined!
 * 
 *	The library "circular_buffer.h" depends on it 
 */
typedef int token;
#include "circular_buffer.h" /* uses data type 'token' */
#include "sdf.h" /* uses circular_buffer.h */
#include <stdio.h>

/* Definition of functions within actors */
void f_1 (token *in, token *out) {
  out[0] = in[0] + in[1];
}

void f_2 (token *in, token *out) {
  out[0] = in[0];
  out[1] = in[0] + 1;
}

void f_3(token *in1, token *in2, token *out) {
  out[0] = in1[0] + in1[1] + in2[0];
}

void f_4 (token *in1, token *in2, token *out1, token* out2) {
  out1[0] = in1[0] + in1[1] + in2[0];
  out2[0] = in1[0] + in1[1];
  out2[1] = in1[0] + in1[1] + in2[0];
}

/* Main program */
int main() {
  token input1, input2, input3, output1, output2;

  /* Create FIFO-buffers for channels */
  token *buffer_s_in1 = malloc(2 * sizeof(token));
  channel s_in1 = createFIFO(buffer_s_in1, 2);

  token *buffer_s_in2 = malloc(1 * sizeof(token));
  channel s_in2 = createFIFO(buffer_s_in2, 1);

  token *buffer_s_out = malloc(2 * sizeof(token));
  channel s_out = createFIFO(buffer_s_out, 2);

  token *Buffer_s_1 = malloc(2 * sizeof(token));
  channel s_1 = createFIFO(Buffer_s_1, 2);

  token *Buffer_s_2 = malloc(2 * sizeof(token));
  channel s_2 = createFIFO(Buffer_s_2, 2);

  token *Buffer_s_3 = malloc(1 * sizeof(token));
  channel s_3 = createFIFO(Buffer_s_3, 1);

  token *Buffer_s_4 = malloc(1 * sizeof(token));
  channel s_4 = createFIFO(Buffer_s_4, 1);

  /* Put initial tokens in channel s_4 */
  writeToken(s_4, 0);

  /* Repeating schedule: */
  while (1)
  {
    /* Read input tokens */
    for (int i = 0; i < 2; ++i) {
      printf("Please input two tokens for A: \n");
      scanf("%d %d", &input1, &input2);
      writeToken(s_in1, input1);
      writeToken(s_in1, input2);
      actor11SDF(2, 1, &s_in1, &s_1, f_1);
    }

    printf("Please input one token for B: \n");
    scanf("%d", &input3);
    writeToken(s_in2, input3);
    actor11SDF(1, 2, &s_in2, &s_2, f_2);

    /* Execute schedule */
    // AABCD. Since AAB has already been executed during the read part, we only need CD here.
    actor21SDF(2, 1, 1, &s_1, &s_4, &s_3, f_3);
    actor22SDF(2, 1, 1, 2, &s_2, &s_3, &s_4, &s_out, f_4);

    /* Write output tokens */
    printf("Output: \n");
    readToken(s_out, &output1);
    readToken(s_out, &output2);
    printf("%d %d\n", output1, output2);
  }
  return 0;
}
