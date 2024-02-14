#include <conv.h>
#include <stdio.h>

int main() {
	int const major = convVersionMajor();
	int const minor = convVersionMinor();
	int const patch = convVersionPatch();
	printf("v%i.%i.%i\n", major, minor, patch);
	return 0;
}
