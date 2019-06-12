

/***************************** Include Files *********************************/

#include "xparameters.h"
#include "xstatus.h"
#include "xuartlite.h"
#include "xil_printf.h"
#include "platform.h"
#include "mb_interface.h"

/************************** Constant Definitions *****************************/

/*
 * The following constants map to the XPAR parameters created in the
 * xparameters.h file. They are defined here such that a user can easily
 * change all the needed parameters in one place.
 */
#define UARTLITE_DEVICE_ID	XPAR_UARTLITE_0_DEVICE_ID

/*
 * The following constant controls the length of the buffers to be sent
 * and received with the UART,
 */
#define INPUT_SIZE 784


/************************** Function Prototypes ******************************/

int UartLitePolledExample(u16 DeviceId);

/************************** Variable Definitions *****************************/

XUartLite UartLite;		/* Instance of the UartLite Device */

/*
 * The following buffers are used in this example to send and receive data
 * with the UartLite.
 */
u8 SendBuffer[INPUT_SIZE];	/* Buffer for Transmitting Data */
u8 RecvBuffer[INPUT_SIZE];	/* Buffer for Receiving Data */

int main(void)
{
		int Status;

		/*
		 * Run the UartLite polled example, specify the Device ID that is
		 * generated in xparameters.h
		 */
		Status = UartLitePolledExample(UARTLITE_DEVICE_ID);
		if (Status != XST_SUCCESS) {
			xil_printf("Uartlite polled  Failed\r\n");
			return XST_FAILURE;
		}


		u8 v;
		unsigned int r;
		unsigned int conc_v;
		xil_printf("\n\rHello Stream Coprocessor\n\r");

		for (int i = 0; i < INPUT_SIZE; i+=4)
		{

			if(i == 0){
				conc_v = (RecvBuffer[i] << 24  )|
						 (RecvBuffer[i+1]<<16) |
						 (RecvBuffer[i+2]<<8)  |
						 (RecvBuffer[i+3]);
			}
			else{
				conc_v = (RecvBuffer[i]<<24)   |
						 (RecvBuffer[i+1]<<16) |
						 (RecvBuffer[i+2]<<8)  |
						 (RecvBuffer[i+3]);
			}

			putfsl(conc_v, 0);

			xil_printf("\n\rInput N:%d ;O0: %u",i,RecvBuffer[i]);
			xil_printf(", O1: %u",RecvBuffer[i+1]);
			xil_printf(", O2: %u",RecvBuffer[i+2]);
			xil_printf(", O3: %u",RecvBuffer[i+3]);


			//xil_printf("\t--Index--%d,--VAL--%u\n\r", i,v);

		}


		for (int i = 0; i < 5; i ++)
		{
			getfsl(r, 0);

			xil_printf("\n\rI:%d", i);
			xil_printf("\n\rR0:%08u", (r >> 24) & 0xFF);
			xil_printf("\n\rR1:%08u", (r >> 16) & 0xFF);
			xil_printf("\n\rR2:%08u", (r >> 8) & 0xFF);
			xil_printf("\n\rR3:%08u", r & 0xFF);

		}







		return XST_SUCCESS;

}

int UartLitePolledExample(u16 DeviceId)
{
	int Status;
	//unsigned int SentCount;
	unsigned int ReceivedCount = 0;


	/*
	 * Initialize the UartLite driver so that it is ready to use.
	 */
	Status = XUartLite_Initialize(&UartLite, DeviceId);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/*
	 * Perform a self-test to ensure that the hardware was built correctly.
	 */
	Status = XUartLite_SelfTest(&UartLite);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}


	/*
	 * Receive the number of bytes which is transfered.
	 * Data may be received in fifo with some delay hence we continuously
	 * check the receive fifo for valid data and update the receive buffer
	 * accordingly.
	 */
	while (1) {
		ReceivedCount += XUartLite_Recv(&UartLite,
					   RecvBuffer + ReceivedCount,
					   INPUT_SIZE - ReceivedCount);
		if (ReceivedCount == INPUT_SIZE) {
			break;
		}
	}

    // show the number in a readable format
    for(int i=0; i < INPUT_SIZE; i++){
        xil_printf("idx %i,%4u\r\n",i,RecvBuffer[i]);
        if((i+1) % 28 == 0){
            xil_printf("\r\n");
        }
    }

	return XST_SUCCESS;


}
