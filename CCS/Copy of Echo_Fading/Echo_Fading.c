
#define CHIP_6713 1

#include <stdio.h>
#include <c6x.h>
#include <csl.h>
#include <csl_mcbsp.h>
#include <csl_irq.h>

#include "dsk6713.h"
#include "dsk6713_aic23.h"

#define N 2000

short buffer[N];
short	i=0;

DSK6713_AIC23_CodecHandle hCodec;
DSK6713_AIC23_Config config = DSK6713_AIC23_DEFAULTCONFIG;

interrupt void serialPortRcvISR(void);

void main()
{
	int aloha = 0;
	for (aloha = 0; aloha < N; aloha++)
		buffer[aloha] = 0;
	DSK6713_init();		// Initialize the board support library, must be called first
    hCodec = DSK6713_AIC23_openCodec(0, &config);

	MCBSP_FSETS(SPCR1, RINTM, FRM);
	MCBSP_FSETS(SPCR1, XINTM, FRM);
	MCBSP_FSETS(RCR1, RWDLEN1, 32BIT);
	MCBSP_FSETS(XCR1, XWDLEN1, 32BIT);
	
	DSK6713_AIC23_setFreq(hCodec, DSK6713_AIC23_FREQ_8KHZ);
		
	IRQ_globalDisable();			// Globally disables interrupts
	IRQ_nmiEnable();				// Enables the NMI interrupt
	IRQ_map(IRQ_EVT_RINT1,15);		// Maps an event to a physical interrupt
	IRQ_enable(IRQ_EVT_RINT1);		// Enables the event
	IRQ_globalEnable();				// Globally enables interrupts

  	/***************************************************************************
  	 * Main Loop, wait for Interrupt	    								   *					               
  	 ***************************************************************************/
	
	while(1)
	{
	}
}

interrupt void serialPortRcvISR()
{
	short input;
	input = MCBSP_read(DSK6713_AIC23_DATAHANDLE);

	buffer[i] = input + buffer[i] * 0.5;


	MCBSP_write(DSK6713_AIC23_DATAHANDLE, buffer[i]);
	i = (i + 1) % N;


}
