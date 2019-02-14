#ifndef __FILEPROCESSOR__
#define __FILEPROCESSOR__

#include <map>
#include <fstream>
#include <vector>
#include <string>

class FileProcessor
{
private:
  static std::map<std::string, int> registerMap;
  static std::map<std::string, int> opMap;
  std::map<std::string, int *> labelMap;
  std::string sourceFile;

public:
  FileProcessor(char *);
  void lookupSymbols();
  void execute();
};

#endif