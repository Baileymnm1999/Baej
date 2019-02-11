#include <string>
#include <regex>
#include <iostream>
#include <sstream>
#include "FileProcessor.h"

FileProcessor::FileProcessor(char *filename)
{
    inFile.open(filename);
    outFile.open("beaj.out", std::ios::out | std::ios::binary);
}

void FileProcessor::parseToken(std::string token)
{
    if (registerMap.find(token) != registerMap.end())
    {
    }
}

void FileProcessor::execute()
{
    int lineCount = 0x00;
    std::string line, token;
    while (getline(inFile, line))
    {
        if (!line.empty())
        {
            // std::regex syntxRegex("^([a-zA-Z]:)? *([(lda)(ldi)(str)(bop)(cal)(beq)(bne)(sft)(cop)(slt)(ret)(add)(sub)(and)(orr)])[ \t]*(.[(f[0-14])(t[0-27])([am][0-5])(v[0-3])(cr)(sp)(z0)(ip)(op)](\[\d+\])? *){,2}[ \t]*(\d+)?");
            // std::regex labelRegex("^([a-zA-Z]:)");
            // std::regex instrRegex("([(lda)(ldi)(str)(bop)(cal)(beq)(bne)(sft)(cop)(slt)(ret)(add)(sub)(and)(orr)])");
            // std::regex paramRegex("(.[(f[0-14])(t[0-27])([am][0-5])(v[0-3])(cr)(sp)(z0)(ip)(op)])");
            // std::regex immedRegex("([\[\d+\]\d+])");

            // std::smatch syntxMatch;
            // std::regex_search(line, syntxMatch, syntxRegex);
            // if (syntxMatch.size() == 1)
            // {
            //     std::cout << "Syntax check passed...\n";
            //     std::smatch instrMatch;
            //     std::regex_search(line, instrMatch, instrRegex);
            //     if (instrMatch.size() == 1)
            //     {
            //     }
            // }

            token = "";
            for (auto c : line)
            {
                switch (c)
                {
                case (':'):
                {
                    int *addr = new int;
                    *addr = lineCount;
                    labelMap[token] = addr;
                    break;
                }
                case ('.'):
                {
                    token = "";
                    break;
                }
                case (']'):
                {
                    addImmediate(token);
                }
                case ('['):
                case ('\n'):
                case (' '):
                {
                    parseToken(token);
                    token = "";
                    break;
                }
                default:
                {
                    token += c;
                }
                }

                if (token != "")
                {
                    lineCount++;
                }
            }
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