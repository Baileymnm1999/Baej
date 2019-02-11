#include <iostream>
#include <fstream>
#include <string.h>
#include "FileProcessor.h"

void error(char *cause);

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        error("Assembler takes one argument. Missing argument <filename>");
    }
    else if (strstr(argv[1], ".baej") == NULL)
    {
        error("Assembler takes .baej file as only argument. Missing argument <filename>");
    }
    else
    {
        FileProcessor(argv[1]).execute();
    }
}

void error(char *cause)
{
    std::cerr << "ERROR: " << *cause;
    exit(-1);
}