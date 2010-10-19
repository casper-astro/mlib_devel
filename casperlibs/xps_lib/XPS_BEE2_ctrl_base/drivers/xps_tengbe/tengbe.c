/* ********************************* */
/* *                               * */
/* *         BEE2 Drivers          * */
/* *                               * */
/* ********************************* */

/* 2006 Pierre-Yves droz */

/* TENGBE access functions */

#include "tengbe.h"
enum { NULLMATCH,FULLMATCH,PARTMATCH,UNMATCH,MATCH,AMBIG };


/* Check if a core is activated or not */
/* ********************************* */
/* size unit is number of 64 bit words */
int conf_valid(Xuint32 tengbe_address)
{
	return (XIo_In8(tengbe_address + VALID_OFFSET) == 0x01) ;
}

/* Send a frame to the network (Blocking) */
/* ********************************* */
/* size unit is number of 64 bit words */
int send_frame(Xuint32 tengbe_address, Xuint8 size)
{
	int i;
	
	/* if the configuration is invalid, we discard the packet without sending it */
	if(!conf_valid(tengbe_address)) return 0;
	
	/* write the size into the size register */	
	XIo_Out8(tengbe_address + TX_SIZE_OFFSET,size);

	/* wait until the frame is accepted by the core (the size is zero) on time out, return 0*/	
	for(i=0;i<10000 && XIo_In8(tengbe_address + TX_SIZE_OFFSET); i++);



if(i==10000) xil_printf("Can't send packet\n");

	return (i!=10000);
}

/* Check if a frame is in the buffer (non blocking) */
/* ********************************* */
/* size unit is number of 64 bit words */
Xuint8 receive_frame(Xuint32 tengbe_address)
{
	/* if the configuration is invalid, we discard the frames that we receive without looking at them */
	if(!conf_valid(tengbe_address)) {
		XIo_Out8(tengbe_address + RX_SIZE_OFFSET, 0x00);
		return 0;
	}
	
	/* return the size of the current frame or zero if there is none */	
	return XIo_In8(tengbe_address + RX_SIZE_OFFSET);
}

/* Discard the current frame in the buffer */
/* ********************************* */
void discard_frame(Xuint32 tengbe_address)
{
	/* write zero to the frame size register to discard the frame */	
	XIo_Out8(tengbe_address + RX_SIZE_OFFSET, 0x00);
}

/* Invalidate current local parameters for the core */
/* ********************************* */
void invalidate_params(Xuint32 tengbe_address)
{
	XIo_Out8(tengbe_address + VALID_OFFSET, 0x00);
	/* wait long enough to guarantee that the core pipeline is flushed */ 
	usleep(1000);
}

/* Validate current local parameters for the core */
/* ********************************* */
void validate_params(Xuint32 tengbe_address)
{
	/* wait long enough to guarantee that the core pipeline is flushed */ 
	usleep(1000);
	XIo_Out8(tengbe_address + VALID_OFFSET, 0x01);
}

/* Set/Get the current local parameters for the core */
/* ********************************* */
void set_mac(Xuint32 tengbe_address, Xuint8* mac)
{
	int i;
	for(i=0; i<6; i++)
		XIo_Out8(tengbe_address + MAC_OFFSET - i, mac[5-i]);
    /* initialize the arp cache with out own MAC address */
    for(i=0; i<256; i++) 
		memcpy((char*) tengbe_address + ARP_CACHE_OFFSET + 8*i + 2,mac,6);

}
void get_mac(Xuint32 tengbe_address, Xuint8* mac)
{
	int i;
	for(i=0; i<6; i++) {
		mac[5-i] = XIo_In8(tengbe_address + MAC_OFFSET - i);
	}
}
void set_ip(Xuint32 tengbe_address, Xuint8* ip)
{
	int i;
	for(i=0; i<4; i++) {
		XIo_Out8(tengbe_address + IP_OFFSET - i, ip[3-i]);
	}
}
void get_ip(Xuint32 tengbe_address, Xuint8* ip)
{
	int i;
	for(i=0; i<4; i++)
		ip[3-i] = XIo_In8(tengbe_address + IP_OFFSET - i);
}
void set_gateway(Xuint32 tengbe_address, Xuint8* gateway)
{
	XIo_Out8(tengbe_address + GATEWAY_OFFSET, *gateway);
}
void get_gateway(Xuint32 tengbe_address, Xuint8* gateway)
{
	*gateway = XIo_In8(tengbe_address + GATEWAY_OFFSET);
}
void set_port(Xuint32 tengbe_address, Xuint16* port)
{
	XIo_Out16(tengbe_address + PORT_OFFSET, *port);
}
void get_port(Xuint32 tengbe_address, Xuint16* port)
{
	*port = XIo_In16(tengbe_address + PORT_OFFSET);
}



/* Dump the parameters of a core */
/* ********************************* */
void tengbinfo_cmd(int argc, char **argv)
/* command = "tengbinfo"                                    */
/* help    = "retreives the current parameters of a core"   */
/* params  = "<10Gb core name>"                             */
{
	char *name;
	int i;
	char ip[4],mac[6];
	Xuint16 port;
	Xuint8  gateway;
	char* arp_cache;

	if(argc!=2) {
		xil_printf("Wrong number of arguments\n\r");
		return;
	}

	name = argv[1];
	
	for(i=0;i<NUM_CORES;i++)
		if(strstart(name,cores[i].name)==FULLMATCH)
		{
			if(cores[i].type != xps_tengbe)
			{
				xil_printf("Core '%s' is not a 10Gb core\n\r",name);
			}
			else
			{
				get_ip(cores[i].address,ip);
				get_mac(cores[i].address,mac);
				get_port(cores[i].address,&port);
				get_gateway(cores[i].address,&gateway);
				xil_printf("MAC address : %02X:%02X:%02X:%02X:%02X:%02X\n\r", mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
				xil_printf("IP  address : %d.%d.%d.%d\n\r", ip[0], ip[1], ip[2], ip[3]);
				xil_printf("Gateway     : %d.%d.%d.%d\n\r", ip[0], ip[1], ip[2], gateway);
				xil_printf("Netmask     : 255.255.255.0\n\r");				
				xil_printf("UDP port    : %d\n\r", port);
				arp_cache = (char*) cores[i].address + ARP_CACHE_OFFSET;
				xil_printf("ARP cache   :\n\r\tIP                 MAC\n\r");
				for(i=0; i<256; i++) {
					xil_printf("\t                   %02X:%02X:%02X:%02X:%02X:%02X \b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b%d.%d.%d.%d\n\r",
						arp_cache[i*8 + 2],
						arp_cache[i*8 + 3],
						arp_cache[i*8 + 4],
						arp_cache[i*8 + 5],
						arp_cache[i*8 + 6],
						arp_cache[i*8 + 7],
						ip[0],
						ip[1],
						ip[2],
						i
					);
				}
			}
			break;
		}

	if(i==NUM_CORES)
		xil_printf("Could not find core named '%s'\n\r",name);

}

/* Output the configuration file character by character for readback */
/* ********************************* */
/* global variables */
int getconf_index;
int tengb_getconf(Xuint32 tengbe_address)
{
	char ip[4],mac[6];
	int base10[6] = {1, 10, 100, 1000, 10000};
	Xuint16 port;
	Xuint8  gateway;
	char tempc;
	int  tempi, tempj;

start:
	getconf_index++;

	get_mac(tengbe_address,mac);
	get_ip(tengbe_address,ip);
	get_gateway(tengbe_address,&gateway);
	get_port(tengbe_address,&port);

	if(getconf_index <= 6)
		return ("begin\n")[getconf_index - 1];
	if(getconf_index <= 13)
		return ("\tmac = ")[getconf_index - 7];
	if(getconf_index <= 30) {
		tempi = ((30 - getconf_index)/3);
		tempj = (getconf_index - 14)%3;
		if (tempj == 2) return ':';
		tempc = (mac[5-tempi] >> (4*(1-tempj))) % 16;
		return (tempc < 10) ? tempc + '0' : tempc - 0x0A + 'A';
	}
	if(getconf_index <= 37)
		return ("\n\tip = ")[getconf_index - 31];;
	if(getconf_index <= 52) {
		tempi = ((52 - getconf_index)/4);
		tempj = (getconf_index - 38)%4;
		if (tempj == 3) return '.';
		if((ip[3-tempi] < base10[2-tempj]) && tempj!=2) goto start;
		return (ip[3-tempi] / base10[2-tempj]) % 10 + '0';
	}
	if(getconf_index <= 64) {
		return ("\n\tgateway = ")[getconf_index - 53];
	}
	if(getconf_index <= 79) {
		ip[3] = gateway;
		tempi = ((79 - getconf_index)/4);
		tempj = (getconf_index - 65)%4;
		if (tempj == 3) return '.';
		if(ip[3-tempi] < base10[2-tempj] && tempj!=2) goto start;
		return (ip[3-tempi] / base10[2-tempj]) % 10 + '0';
	}
	if(getconf_index <= 88) {
		return ("\n\tport = ")[getconf_index - 80];
	}
	if(getconf_index <= 93) {
		if(port < base10[93-getconf_index] && getconf_index!=93) goto start;
		return (port / base10[93-getconf_index]) % 10 + '0';
	}
	if(getconf_index <= 98) {
		return ("\nend\n")[getconf_index - 94];
	}
	getconf_index = 0;
	return -1;
}

/* Parses configuration file character by character */
/* ********************************* */
/* global variables */
char setconf_line[32];
int  setconf_size = 0;
int isnumber(char c) {return (c >= '0' && c <= '9');};
int ishex(char c) {return (c >= '0' && c <= '9') || (c >= 'A' && c <= 'F') || (c >= 'a' && c <= 'f');};

void tengb_setconf(Xuint32 tengbe_address, char c)
{
	int i,j;
	int temp_ip, temp_port;
	char* current_line;
	char ip[4],mac[6];
	Xuint16 port;
	Xuint8  gateway;
	
	/* add the characters to the current line */
	if(setconf_size < 30) {
		if(c != ' ' && c != '\t' && c != '\r')
		setconf_line[setconf_size++] = c;
		setconf_line[setconf_size]   = 0;
	} else {
		setconf_size     = 0;
		setconf_line[0]  = 0;
	}

	current_line = setconf_line;
	
	/* if the last char was a carriage return, then try to parse the line */
	if(c == '\n') {
		/* begin command */
		/* cause the core to stop sending packets while we are updating the parameters */
		if(strstart(current_line,"begin")==PARTMATCH && current_line[5] == '\n') {
			invalidate_params(tengbe_address);
		} else
		if(strstart(current_line,"end")==PARTMATCH && current_line[3] == '\n') {
			validate_params(tengbe_address);
		} else
		if(strstart(current_line,"mac=")==PARTMATCH) {
			current_line += 4;
			for(i=5;i>=0;i--) {
				if(ishex(current_line[0]) && ishex(current_line[1]) && (current_line[2] == ':' || (i==0 && current_line[2] == '\n'))) {
					current_line[2] = 0;
					current_line[-1] = 'x';
					mac[5-i] = tinysh_atoxi(current_line - 1);
					current_line += 3;
				} else break;
			}
			if(i==-1)
				set_mac(tengbe_address,mac);
		} else
		if(strstart(current_line,"ip=")==PARTMATCH) {
			current_line += 3;
			for(i=3;i>=0;i--) {
				for(j=0; isnumber(current_line[j]) && j < 4; j++);
				if(j > 0 && j < 4 && (current_line[j] == '.' || (i==0 && current_line[j] == '\n'))) {
					current_line[j] = 0;
					temp_ip = tinysh_atoxi(current_line);
					if(temp_ip >= 256) break;
					ip[3-i] = temp_ip;
					current_line += j + 1;
				} else break;
			}
			if(i==-1)
				set_ip(tengbe_address,ip);
		} else
		if(strstart(current_line,"gateway=")==PARTMATCH) {
			get_ip(tengbe_address,ip);
			current_line += 8;
			for(i=3;i>=0;i--) {
				for(j=0; isnumber(current_line[j]) && j < 4; j++);
				if(j > 0 && j < 4 && (current_line[j] == '.' || (i==0 && current_line[j] == '\n'))) {
					current_line[j] = 0;
					temp_ip = tinysh_atoxi(current_line);
					if(i==0) {
						if(temp_ip >= 256) break;
						gateway = temp_ip;
					} else
						if(temp_ip != ip[3-i]) break;
					current_line += j + 1;
				} else break;
			}
			if(i==-1)
				set_gateway(tengbe_address,&gateway);
		} else
		if(strstart(current_line,"port=")==PARTMATCH) {
			current_line += 5;
			for(j=0; isnumber(current_line[j]) && j < 6; j++);
			if(j > 0 && j < 6 && (current_line[j] == '\n')) {
				current_line[j] = 0;
				temp_port = tinysh_atoxi(current_line);
				if(temp_port < 65536) {
					port = temp_port;
					set_port(tengbe_address,&port);
				}
			} 
		}

		setconf_size     = 0;
		setconf_line[0]  = 0;		
	}

}

/* Checksum generation functions */
/* ********************************* */
/* offsets are char offsets */
void add_checksum(Xuint32 tengbe_address, int start, int end, int position)
{
	unsigned short* tx_buffer_short = (short*) ((char*) tengbe_address + TX_BUFFER_OFFSET);
	unsigned int checksum = 0;
	int i;

	/* changes the offsets to short offsets */
	position /= 2;
	start    /= 2;
	end      /= 2;

	/* zeros the checksum */
	tx_buffer_short[position] = 0x0000;

	/* add-up all the words as a 32 bit number */
	for(i=start;i<=end;i++)
		checksum += tx_buffer_short[i];

	/* transform the two complement checksum into a one complement checksum by adding the MSBs into the LSBs */
	checksum = ~ ((checksum & 0xFFFF) + (checksum >> 16));
	
	/* write back the result */
	tx_buffer_short[position] = checksum;
	
}


/* Repeating function handling the main processing of the packets */
/* ********************************* */
char arp_rotating_ip_last[4] = {0,0,0,0};
XTime last[4] = {0,0,0,0};

void tengb_repeat()
/* repeat  */
{
	int size;
	int i,j;
	char* rx_buffer;
	char* tx_buffer;
	char* arp_cache;
	short* protocol;
	short cmd;
	char arp_header[6] = {0x00, 0x01, 0x08, 0x00, 0x06, 0x04};
	char ip_header[6] = {0x00, 0x00, 0x40, 0x00, 0x40, 0x01};
	char broadcast[6] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
	char ip[4];
	char mac[6];
	short ip_size;
	char ip_protocol;
	char ip_last;
	XTime now;
	int current_core_index = 0;

	/* loop on each ten Gb Ethernet core */
	for(i=0;i<NUM_CORES;i++)
		if(cores[i].type == xps_tengbe)
		{
			rx_buffer = (char*) cores[i].address + RX_BUFFER_OFFSET;
			tx_buffer = (char*) cores[i].address + TX_BUFFER_OFFSET;
			arp_cache = (char*) cores[i].address + ARP_CACHE_OFFSET;			
			get_ip(cores[i].address, ip);
			get_mac(cores[i].address, mac);
			protocol = (short*) (rx_buffer + 12);
								
			/* check if there is a new frame */
			size = receive_frame(cores[i].address);
			if(size) {
//				xil_printf("Received Frame of size %d words with protocol %04X\n\r", size, *protocol);
//				for(j=0;j<size*8;j++) {
//					if(j%16==0) xil_printf("\n0x%02X   ",j);
//					xil_printf("%02X ", rx_buffer[j]);						
//				}
//				xil_printf("\n");
				
				switch (*protocol) {
					case 0x0806: /* ARP */
						/* check validity of packet */
						for(j=0;j<6 && arp_header[j] == rx_buffer[14+j];j++);
						if (j != 6) break;						
						/* check if we are the target */
						for(j=0;j<4 && rx_buffer[38 + j] == ip[j];j++);
						if (j != 4) break;
						/* get the ARP operation */
						cmd = *((short*) (rx_buffer+20));
						switch(cmd) {
							/* request */
							case 0x0001:
								/* Send the ARP reply */
								/* destination */
								memcpy(tx_buffer,rx_buffer + 6,6);
								/* source */
								memcpy(tx_buffer + 6,mac, 6);
								/* protocol */
								tx_buffer[12] = 0x08;
								tx_buffer[13] = 0x06;
								/* arp header */
								memcpy(tx_buffer + 14,arp_header,6);
								/* arp answer */
								tx_buffer[20] = 0x00;
								tx_buffer[21] = 0x02;
								/* sender hardware address */
								memcpy(tx_buffer + 22,mac,6);
								/* sender protocol address */
								memcpy(tx_buffer + 28,ip,4);
								/* target hardware address */
								memcpy(tx_buffer + 32,rx_buffer + 22,6);
								/* target protocol address */
								memcpy(tx_buffer + 38,rx_buffer + 28,4);
								/* send the frame - extended to make sure that it fits in the ethernet Minimum Transfert Unit */
								send_frame(cores[i].address, 8);
								break;
							/* reply */
							case 0x0002:
								/* read the ip and make sure it is part of our subnet */
								for(j=0;j<3 && rx_buffer[28 + j] == ip[j];j++);
								if (j != 3) break;
								/* get the last byte of the source ip */
								ip_last = rx_buffer[31];
								/* write the source mac in the ARP cache */
								memcpy(arp_cache + 8*ip_last + 2,rx_buffer + 22,6);
								break;
						}
						break;
					case 0x0800: /* IP */
						/* check validity of packet */
						/* ip version and length */
						if(rx_buffer[14] != 0x45) break;
						/* check if we are the destination */
						for(j=0;j<4 && rx_buffer[30 + j] == ip[j];j++);
						/* get the ip size */
						ip_size = *((short*) (rx_buffer + 16));
						/* get the protocol */
						ip_protocol = rx_buffer[23];
						switch(ip_protocol) {
							/* ICMP */
							case 0x01:
								/* icmp request with code 0 */
								if(rx_buffer[34] != 0x08) break;
								if(rx_buffer[35] != 0x00) break;				
								/* Ok the ping is for us, let's reply */
								/* destination */
								memcpy(tx_buffer,rx_buffer + 6,6);
								/* source */
								memcpy(tx_buffer + 6,mac, 6);
								/* protocol */
								tx_buffer[12] = 0x08;
								tx_buffer[13] = 0x00;
								/* IP header */
								tx_buffer[14] = 0x45;
								tx_buffer[15] = 0x00;
								/* IP size */
								memcpy(tx_buffer + 16,rx_buffer + 16,6);
								/* IP header */
								memcpy(tx_buffer + 18,ip_header,6);
								/* Source IP */
								memcpy(tx_buffer + 26,ip,6);
								/* Destination IP */
								memcpy(tx_buffer + 30,rx_buffer + 26,6);
								/* IP checksum */
								add_checksum(cores[i].address, 14, 33, 24);
								/* icmp reply with code 0 */
								tx_buffer[34] = 0x00;
								tx_buffer[35] = 0x00;
								/* Identifier */
								memcpy(tx_buffer + 38,rx_buffer + 38,2);
								/* Sequence number */
								memcpy(tx_buffer + 40,rx_buffer + 40,2);
								/* Payload */
								memcpy(tx_buffer + 42,rx_buffer + 42, ip_size - 28);
								/* ICMP checksum */
								add_checksum(cores[i].address, 34, ip_size + 13, 36);
								/* send the frame */
								send_frame(cores[i].address, size);
								break;
						}													
						break;
				}
				discard_frame(cores[i].address);
			}

			/* send ARP requests to the different hosts on the network ARP_RATE times per second */								
			XTime_GetTime(&now);
			if((now - last[current_core_index]) * ARP_RATE > ((XTime) XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ)) {
				/* store time for the next time */
				XTime_GetTime(&(last[current_core_index]));

				/* Send an ARP request */
				/* destination broadcast */
				memcpy(tx_buffer,broadcast,6);
				/* source */
				memcpy(tx_buffer + 6,mac, 6);
				/* protocol */
				tx_buffer[12] = 0x08;
				tx_buffer[13] = 0x06;
				/* arp header */
				memcpy(tx_buffer + 14,arp_header,6);
				/* arp request */
				tx_buffer[20] = 0x00;
				tx_buffer[21] = 0x01;
				/* sender hardware address */
				memcpy(tx_buffer + 22,mac,6);
				/* sender protocol address */
				memcpy(tx_buffer + 28,ip,4);
				/* target hardware address */
				memcpy(tx_buffer + 32,broadcast,6);
				/* target protocol address */
				memcpy(tx_buffer + 38,ip,3);
				tx_buffer[41] = arp_rotating_ip_last[current_core_index]++;
				/* send the frame - extended to make sure that it fits in the ethernet Minimum Transfert Unit */
				send_frame(cores[i].address, 8);
			}
			current_core_index++;
		}
}


