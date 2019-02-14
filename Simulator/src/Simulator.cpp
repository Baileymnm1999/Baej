#include <string>
#include <iostream>
#include <regex>
#include <bitset>
#include <sstream>
#include "Simulator.h"

Simulator::Simulator(char *filename, int input)
{
    sourceFile = *new std::string(filename);
    regFile[15] = input;
    pc = 0;
}

void Simulator::execute()
{
    readProg();
    execProg();
    std::cout << "OUTPUT: " << regFile[16] << "\n";
}

void Simulator::readProg()
{
    std::ifstream source(sourceFile);
    std::string line;
    int i = 0;
    while (getline(source, line))
    {
        mem[i] = line;
        i++;
    }
}

void Simulator::execProg()
{
    int op, rs, rd, im;
    while (!mem[pc].empty())
    {
        // std::cout << pc << '\n';
        op = std::stoi(mem[pc].substr(0, 4), nullptr, 2);
        rs = std::stoi(mem[pc].substr(4, 6), nullptr, 2);
        rd = std::stoi(mem[pc].substr(10, 6), nullptr, 2);
        im = mem[pc + 1].empty() ? 0 : std::stoi(mem[pc + 1], nullptr, 2);
        // std::cout << op << " " << rs << " " << rd << "\n"
        //           << im << "\n";
        regFile[63] = 0;

        switch (op)
        {
        case 0:
        {
            regFile[rd] = std::stoi(mem[rs + im], nullptr, 2);
            pc += 2;
            break;
        }
        case 1:
        {
            regFile[rd] = im;
            pc += 2;
            break;
        }
        case 2:
        {
            mem[rs + im] = std::bitset<16>(regFile[rd]).to_string();
            pc += 2;
            break;
        }
        case 3:
        {
            if (im == pc)
                return;
            pc = im;
            break;
        }
        case 4:
        {
            ra.push(pc + 2);
            backup();
            pc = im;
            break;
        }
        case 5:
        {
            if (regFile[rs] == regFile[rd])
                pc = im;
            else
                pc += 2;
            break;
        }
        case 6:
        {
            if (regFile[rs] != regFile[rd])
                pc = im;
            else
                pc += 2;
            break;
        }
        case 7:
        {
            if (im > 0)
                regFile[rd] = regFile[rs] << im;
            else
            {
                unsigned int l = -1;
                im ^= l;
                im += 1;
                regFile[rd] = regFile[rs] >> im;
            }
            pc += 2;
            break;
        }
        case 8:
        {
            regFile[rd] = regFile[rs];
            pc += 1;
            break;
        }
        case 10:
        {
            regFile[57] = regFile[rs] < regFile[rd] ? 1 : 0;
            pc += 1;
            break;
        }
        case 11:
        {
            pc = ra.top();
            ra.pop();
            restore();
            break;
        }
        case 12:
        {
            regFile[rd] += regFile[rs];
            pc += 1;
            break;
        }
        case 13:
        {
            regFile[rd] -= regFile[rs];
            pc += 1;
            break;
        }
        case 14:
        {
            regFile[rd] &= regFile[rs];
            pc += 1;
            break;
        }
        case 15:
        {
            regFile[rd] |= regFile[rs];
            pc += 1;
            break;
        }
        default:
            break;
        }
    }
}

void Simulator::backup()
{
    for (int i = 0; i < 15; i++)
        cache.push(regFile[i]);
}

void Simulator::restore()
{
    for (int i = 0; i < 15; i++)
    {
        regFile[i] = cache.top();
        cache.pop();
    }
}