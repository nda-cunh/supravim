namespace Utils {
	[CCode (cname = "sprintf", cheader_filename = "stdio.h")]
	private extern int sprintf(char *str, char *format, ...);
}
