
#define CHIP_6713 1
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <c6x.h>
#include <csl.h>
#include <csl_mcbsp.h>
#include <csl_irq.h>
#include "dsk6713.h"
#include "dsk6713_aic23.h"
#include "dsk6713_dip.h"
#include "sine160.h"
#include "LP114.h"

#define PI 3.14159265
#define N1 8000
#define f0 3300
#define fs 16000

short gain = 1;
short input;
union {Uint32 combo; short channel[2];}temp;
//union {Uint32 combo; short channel[2];}lowpassed;
//union {Uint32 combo; short channel[2];}scrambled;
//union {Uint32 combo; short channel[2];}unscrambled;
short buff[N];
short buff2[N];
short buff3[N];
short buff4[N];
int shift = 15;

DSK6713_AIC23_CodecHandle hCodec;
DSK6713_AIC23_Config config = DSK6713_AIC23_DEFAULTCONFIG;

interrupt void serialPortRcvISR(void);
short myfilter(short inp, short *buff);
short mod(short input);
short mod1(short input);

void main()
 {

	DSK6713_init();		// Initialize the board support library, must be called first
    hCodec = DSK6713_AIC23_openCodec(0, &config);
	MCBSP_FSETS(SPCR1, RINTM, FRM);
	MCBSP_FSETS(SPCR1, XINTM, FRM);
	MCBSP_FSETS(RCR1, RWDLEN1, 32BIT);
	MCBSP_FSETS(XCR1, XWDLEN1, 32BIT);
	DSK6713_AIC23_setFreq(hCodec, DSK6713_AIC23_FREQ_16KHZ);

	IRQ_globalDisable();			// Globally disables interrupts
	IRQ_nmiEnable();				// Enables the NMI interrupt
	IRQ_map(IRQ_EVT_RINT1,15);		// Maps an event to a physical interrupt
	IRQ_enable(IRQ_EVT_RINT1);		// Enables the event
	IRQ_globalEnable();				// Globally enables interrupts

//	int i5;
//	for (i5=0;i5<N;i5++){
//		buff[i5]=0;
//		buff2[i5]=0;
//		buff3[i5]=0;
//		buff4[i5]=0;
//	}

	/***************************************************************************
  	 * Main Loop, wait for Interrupt	    								   *					               
  	 ***************************************************************************/
	
	while(1)
	{
	}

}



interrupt void serialPortRcvISR()
{
	short y;
	temp.combo = MCBSP_read(DSK6713_AIC23_DATAHANDLE);
	input = temp.channel[0];

	y = myfilter(input,buff);
	y = mod(y);
	y = myfilter(y,buff);

	temp.channel[0] = y;
	temp.channel[1] = temp.channel[0];
	MCBSP_write(DSK6713_AIC23_DATAHANDLE, gain*temp.combo);

}


short myfilter(short inp, short *buff){
	short i;
	int y = 0;
	for(i = 1; i < N ; i++ )
		buff[i-1] = buff[i];
	buff[N-1] = inp;
	///////////
	for(i = 0;i < N; i++ )
		y = y + buff[i] * h[i] ;
	///////////
	return (y >> shift);
}


short mod(short input){
	static short i1 = 0;
	input = input * cos(2 * PI * (f0 / fs) * i1);
	i1++;
	i1 = i1 % 160;
	return input;
}

short mod1(short input){
	static short i2 = 0;

	return input;
}
