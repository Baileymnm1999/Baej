#include <string>
#include <regex>
#include <iostream>
#include <sstream>
#include "FileProcessor.h"

FileProcessor::FileProcessor(char *filename)
{
    sourceFile = *new std::string(filename);
    // inFile.open(filename);
    // outFile.open("beaj.out", std::ios::out | std::ios::binary);
}

void FileProcessor::execute()
{
    lookupSymbols();

    int lineCount = 0x00;
    std::string line, token;
    // while (getline(inFile, line))
    // {
    //     if (!line.empty())
    //     {
    //         l = "";
    //         for (auto c : line)
    //         {
    //             switch (c)
    //             {
    //             case (':'):
    //             {
    //                 int *addr = new int;
    //                 *addr = lineCount;
    //                 labelMap[token] = addr;
    //                 break;
    //             }
    //             case ('.'):
    //             {
    //                 token = "";
    //                 break;
    //             }
    //             case (']'):
    //             {
    //                 addImmediate(token);
    //             }
    //             case ('['):
    //             case ('\n'):
    //             case (' '):
    //             {
    //                 parseToken(token);
    //                 token = "";
    //                 break;
    //             }
    //             default:
    //             {
    //                 token += c;
    //             }
    //             }

    //             if (token != "")
    //             {
    //                 lineCount++;
    //             }
    //         }
    //     }
    // }
}

void FileProcessor::lookupSymbols()
{
    std::ifstream infile(sourceFile);

    int addr = 0x00;
    std::string line, symbol;
    while (getline(infile, line))
    {
        if (!line.empty())
        {
            int pos = line.find_first_of(":", 0);
            if (pos != std::string::npos)
            {
                symbol = line.substr(0, pos);
                std::cout << "FOUND SYMBOL: " << symbol << "\n";
                line = line.substr(pos + 1);
            }
            std::string arr[4];
            int i = 0;
            std::stringstream ssin(line);
            while (ssin.good() && i < 4)
            {
                ssin >> arr[i];
                std::cout << arr[i] << " ";
                ++i;
            }
            std::cout << "\n";
        }
    }
}

std::map<std::string, int> FileProcessor::opMap =
    {{"lda", 0},
     {"ldi", 1},
     {"str", 2},
     {"bop", 3},
     {"cal", 4},
     {"beq", 5},
     {"bne", 6},
     {"sft", 7},
     {"cop", 8},
     {"slt", 10},
     {"ret", 11},
     {"add", 12},
     {"sub", 13},
     {"and", 14},
     {"orr", 15}};

std::map<std::string, int> FileProcessor::registerMap =
    {{"f0", 0},
     {"f1", 1},
     {"f2", 2},
     {"f3", 3},
     {"f4", 4},
     {"f5", 5},
     {"f6", 6},
     {"f7", 7},
     {"f8", 8},
     {"f9", 9},
     {"f10", 10},
     {"f11", 11},
     {"f12", 12},
     {"f13", 13},
     {"f14", 14},
     {"ip", 15},
     {"op", 16},
     {"t0", 17},
     {"t1", 18},
     {"t2", 19},
     {"t3", 20},
     {"t4", 21},
     {"t5", 22},
     {"t6", 23},
     {"t7", 24},
     {"t8", 25},
     {"t9", 26},
     {"t10", 27},
     {"t11", 28},
     {"t12", 29},
     {"t13", 30},
     {"t14", 31},
     {"t15", 32},
     {"t16", 33},
     {"t17", 34},
     {"t18", 35},
     {"t19", 36},
     {"t20", 37},
     {"t21", 38},
     {"t22", 39},
     {"t23", 40},
     {"t24", 41},
     {"t25", 42},
     {"t26", 43},
     {"t27", 44},
     {"a0", 45},
     {"a1", 46},
     {"a2", 47},
     {"a3", 48},
     {"a4", 49},
     {"a5", 50},
     {"m0", 51},
     {"m1", 52},
     {"m2", 53},
     {"m3", 54},
     {"m4", 55},
     {"m5", 56},
     {"cr", 57},
     {"v0", 58},
     {"v1", 59},
     {"v2", 60},
     {"v3", 61},
     {"sp", 62},
     {"z0", 63}};