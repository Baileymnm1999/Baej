#ifndef __SIMULATOR__
#define __SIMULATOR__

#include <map>
#include <fstream>
#include <vector>
#include <stack>
#include <string>

class Simulator
{
private:
  int regFile[64];
  int pc;
  std::stack<int> ra;
  std::stack<int> cache;
  std::string mem[1024];
  std::string sourceFile;
  void readProg();
  void execProg();
  void backup();
  void restore();

public:
  Simulator(char *, int);
  void execute();
};

#endif